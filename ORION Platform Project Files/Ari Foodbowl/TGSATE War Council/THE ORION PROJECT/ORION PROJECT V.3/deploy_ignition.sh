#!/bin/bash
# ============================================
# ORION CHRONICLES IGNITION SCRIPT v3.0
# Production Deployment & Launch
# ============================================

set -e  # Exit on error
set -o pipefail

# ==================== CONFIGURATION ====================
ORION_HOME="${ORION_HOME:-$(pwd)}"
VENV_NAME="orion_venv"
APP_PORT="${PORT:-8501}"
DB_PORT="${DB_PORT:-5432}"
REDIS_PORT="${REDIS_PORT:-6379}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ==================== FUNCTIONS ====================
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_dependency() {
    if ! command -v $1 &> /dev/null; then
        log_error "Missing dependency: $1"
        log_info "Please install $1 and try again"
        exit 1
    fi
}

# ==================== DEPENDENCY CHECK ====================
log_info "Checking system dependencies..."

REQUIRED_DEPS=("python3.10" "pip" "docker" "git" "curl")
OPTIONAL_DEPS=("docker-compose" "nginx" "certbot")

for dep in "${REQUIRED_DEPS[@]}"; do
    check_dependency "$dep"
done

for dep in "${OPTIONAL_DEPS[@]}"; do
    if ! command -v $dep &> /dev/null; then
        log_warning "Optional dependency missing: $dep"
    fi
done

# ==================== DIRECTORY STRUCTURE ====================
log_info "Creating directory structure..."

mkdir -p "${ORION_HOME}/"{core,dashboard,database,deploy,logs,data,config}
mkdir -p "${ORION_HOME}/data/"{postgres,redis,uploads,backups}

# ==================== PYTHON ENVIRONMENT ====================
log_info "Setting up Python environment..."

cd "${ORION_HOME}"

if [ ! -d "${VENV_NAME}" ]; then
    python3.10 -m venv "${VENV_NAME}"
    log_success "Virtual environment created"
fi

# Activate venv
source "${VENV_NAME}/bin/activate"

# Upgrade pip
pip install --upgrade pip setuptools wheel

# Install requirements
log_info "Installing Python packages..."

cat > requirements.txt << 'EOF'
# Core dependencies
streamlit==1.28.0
plotly==5.17.0
numpy==1.24.0
pandas==2.0.0
pydantic==2.4.0
aiohttp==3.9.0
asyncpg==0.29.0
redis==5.0.0
python-dotenv==1.0.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4

# AI/ML
openai==1.3.0
google-generativeai==0.3.0
anthropic==0.7.0
langchain==0.0.340
langchain-community==0.0.10

# Database
sqlalchemy==2.0.20
alembic==1.12.0
psycopg2-binary==2.9.9

# Utilities
python-multipart==0.0.6
email-validator==2.1.0
uvicorn[standard]==0.24.0
fastapi==0.104.0
celery==5.3.0

# Monitoring
prometheus-client==0.19.0
sentry-sdk==1.35.0

# Development
black==23.11.0
flake8==6.1.0
pytest==7.4.3
pytest-asyncio==0.21.1
EOF

pip install -r requirements.txt
log_success "Python packages installed"

# ==================== DATABASE SETUP ====================
log_info "Setting up PostgreSQL with pgvector..."

# Check if Docker is running
if ! docker info &> /dev/null; then
    log_error "Docker is not running"
    log_info "Starting Docker..."
    sudo systemctl start docker
    sleep 5
fi

# Create Docker network if it doesn't exist
docker network create orion-network 2>/dev/null || true

# Start PostgreSQL with pgvector
if ! docker ps --format '{{.Names}}' | grep -q "orion-postgres"; then
    log_info "Starting PostgreSQL container..."
    
    docker run -d \
        --name orion-postgres \
        --network orion-network \
        -p ${DB_PORT}:5432 \
        -e POSTGRES_USER=orion_admin \
        -e POSTGRES_PASSWORD="$(openssl rand -hex 16)" \
        -e POSTGRES_DB=orion_chronicles \
        -v "${ORION_HOME}/data/postgres:/var/lib/postgresql/data" \
        -v "${ORION_HOME}/database:/docker-entrypoint-initdb.d" \
        --restart unless-stopped \
        pgvector/pgvector:pg15
    
    # Wait for database to be ready
    log_info "Waiting for database to be ready..."
    sleep 10
    for i in {1..30}; do
        if docker exec orion-postgres pg_isready -U orion_admin &> /dev/null; then
            log_success "PostgreSQL is ready"
            break
        fi
        if [ $i -eq 30 ]; then
            log_error "PostgreSQL failed to start"
            exit 1
        fi
        sleep 2
    done
else
    log_info "PostgreSQL container already running"
fi

# Initialize database schema
log_info "Initializing database schema..."
docker exec -i orion-postgres psql -U orion_admin -d orion_chronicles \
    < "${ORION_HOME}/database/orion_schema.sql"

log_success "Database schema initialized"

# ==================== REDIS SETUP ====================
log_info "Setting up Redis for caching..."

if ! docker ps --format '{{.Names}}' | grep -q "orion-redis"; then
    docker run -d \
        --name orion-redis \
        --network orion-network \
        -p ${REDIS_PORT}:6379 \
        -v "${ORION_HOME}/data/redis:/data" \
        --restart unless-stopped \
        redis:7-alpine redis-server --appendonly yes
    
    log_success "Redis container started"
else
    log_info "Redis container already running"
fi

# ==================== CONFIGURATION FILES ====================
log_info "Creating configuration files..."

# Environment configuration
cat > .env << EOF
# Orion Chronicles Environment Configuration
# Generated: $(date)

# Database
DB_HOST=localhost
DB_PORT=${DB_PORT}
DB_NAME=orion_chronicles
DB_USER=orion_admin
DB_PASSWORD=$(docker exec orion-postgres printenv POSTGRES_PASSWORD)

# Redis
REDIS_URL=redis://localhost:${REDIS_PORT}/0
REDIS_CACHE_TTL=3600

# API Keys (configure these in production)
OPENAI_API_KEY=${OPENAI_API_KEY:-}
ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY:-}
GOOGLE_API_KEY=${GOOGLE_API_KEY:-}
PERPLEXITY_API_KEY=${PERPLEXITY_API_KEY:-}
DEEPSEEK_API_KEY=${DEEPSEEK_API_KEY:-}

# App Settings
APP_PORT=${APP_PORT}
APP_ENV=production
APP_SECRET_KEY=$(openssl rand -hex 32)
JWT_SECRET_KEY=$(openssl rand -hex 32)

# Security
CORS_ORIGINS=["http://localhost:${APP_PORT}", "http://127.0.0.1:${APP_PORT}"]
RATE_LIMIT_PER_MINUTE=60

# Ghost Rider
GHOST_RIDER_STRICT_MODE=true
MAX_INPUT_LENGTH=5000

# Mycelial Highway
MIN_RESONANCE_SCORE=0.6
MAX_SEEDS_PER_USER=100
SEED_EXPIRY_DAYS=30

# Monitoring
SENTRY_DSN=${SENTRY_DSN:-}
PROMETHEUS_PORT=9090
EOF

log_success "Environment file created"

# Nginx configuration for production
if command -v nginx &> /dev/null; then
    cat > /etc/nginx/sites-available/orion-chronicles << EOF
server {
    listen 80;
    server_name localhost;
    
    location / {
        proxy_pass http://localhost:${APP_PORT};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
    }
    
    location /metrics {
        proxy_pass http://localhost:9090;
    }
}
EOF
    
    ln -sf /etc/nginx/sites-available/orion-chronicles /etc/nginx/sites-enabled/
    nginx -t && systemctl reload nginx
    log_success "Nginx configuration updated"
fi

# ==================== SYSTEMD SERVICE ====================
log_info "Creating systemd service..."

cat > /etc/systemd/system/orion-chronicles.service << EOF
[Unit]
Description=Orion Chronicles Command Deck
After=network.target docker.service
Requires=docker.service

[Service]
Type=exec
User=$(whoami)
WorkingDirectory=${ORION_HOME}
EnvironmentFile=${ORION_HOME}/.env
ExecStart=${ORION_HOME}/${VENV_NAME}/bin/streamlit run dashboard/orion_dashboard.py \\
    --server.port \${APP_PORT} \\
    --server.address 0.0.0.0 \\
    --server.fileWatcherType none \\
    --server.headless true \\
    --browser.serverAddress localhost \\
    --browser.gatherUsageStats false
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=orion-chronicles
Environment=PYTHONUNBUFFERED=1

# Security
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ReadWritePaths=${ORION_HOME}/data ${ORION_HOME}/logs

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable orion-chronicles.service

log_success "Systemd service created"

# ==================== BACKUP SCRIPT ====================
log_info "Creating backup script..."

cat > "${ORION_HOME}/deploy/backup.sh" << 'EOF'
#!/bin/bash
BACKUP_DIR="${ORION_HOME}/data/backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "${BACKUP_DIR}"

log_info "Starting backup..."

# Backup PostgreSQL
docker exec orion-postgres pg_dump -U orion_admin orion_chronicles > "${BACKUP_DIR}/database.sql"
tar -czf "${BACKUP_DIR}/database.tar.gz" "${BACKUP_DIR}/database.sql"

# Backup Redis
docker exec orion-redis redis-cli SAVE
docker cp orion-redis:/data/dump.rdb "${BACKUP_DIR}/redis.rdb"

# Backup uploaded files
tar -czf "${BACKUP_DIR}/uploads.tar.gz" -C "${ORION_HOME}/data/uploads" .

# Backup logs
tar -czf "${BACKUP_DIR}/logs.tar.gz" -C "${ORION_HOME}/logs" .

# Create backup manifest
cat > "${BACKUP_DIR}/manifest.json" << MANIFEST
{
    "timestamp": "$(date -Iseconds)",
    "components": {
        "database": "database.tar.gz",
        "redis": "redis.rdb",
        "uploads": "uploads.tar.gz",
        "logs": "logs.tar.gz"
    },
    "orion_version": "3.0",
    "backup_size": "$(du -sh ${BACKUP_DIR} | cut -f1)"
}
MANIFEST

# Cleanup old backups (keep last 7 days)
find "${ORION_HOME}/data/backups" -type d -mtime +7 -exec rm -rf {} \;

log_success "Backup completed: ${BACKUP_DIR}"
EOF

chmod +x "${ORION_HOME}/deploy/backup.sh"

# ==================== MONITORING SETUP ====================
log_info "Setting up monitoring..."

# Prometheus configuration
if command -v docker &> /dev/null; then
    cat > "${ORION_HOME}/deploy/prometheus.yml" << EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'orion_app'
    static_configs:
      - targets: ['localhost:${APP_PORT}']
    
  - job_name: 'postgres'
    static_configs:
      - targets: ['localhost:9187']
    
  - job_name: 'redis'
    static_configs:
      - targets: ['localhost:9121']
EOF

    # Start Prometheus
    docker run -d \
        --name orion-prometheus \
        --network orion-network \
        -p 9090:9090 \
        -v "${ORION_HOME}/deploy/prometheus.yml:/etc/prometheus/prometheus.yml" \
        prom/prometheus
    
    # Start PostgreSQL exporter
    docker run -d \
        --name orion-postgres-exporter \
        --network orion-network \
        -p 9187:9187 \
        -e DATA_SOURCE_NAME="postgresql://orion_admin:$(docker exec orion-postgres printenv POSTGRES_PASSWORD)@orion-postgres:5432/orion_chronicles?sslmode=disable" \
        prometheus-community/postgres-exporter
    
    # Start Redis exporter
    docker run -d \
        --name orion-redis-exporter \
        --network orion-network \
        -p 9121:9121 \
        -e REDIS_ADDR="redis://orion-redis:6379" \
        oliver006/redis_exporter
    
    log_success "Monitoring stack started"
fi

# ==================== HEALTH CHECK ====================
log_info "Running health checks..."

# Check if services are running
services=("orion-postgres" "orion-redis" "orion-prometheus")
all_healthy=true

for service in "${services[@]}"; do
    if docker ps --format '{{.Names}}' | grep -q "^${service}$"; then
        log_success "${service} is running"
    else
        log_error "${service} is not running"
        all_healthy=false
    fi
done

if $all_healthy; then
    log_success "All services are healthy"
else
    log_warning "Some services are not running correctly"
fi

# ==================== START APPLICATION ====================
log_info "Starting Orion Chronicles Command Deck..."

systemctl start orion-chronicles.service
sleep 5

if systemctl is-active --quiet orion-chronicles.service; then
    log_success "Orion Chronicles is running!"
    
    # Display access information
    cat << EOF

${GREEN}===========================================
   ORION CHRONICLES DEPLOYMENT COMPLETE!
===========================================${NC}

${YELLOW}ACCESS INFORMATION:${NC}
🌐 Dashboard:      http://localhost:${APP_PORT}
📊 Metrics:        http://localhost:9090
🗄️  Database:      localhost:${DB_PORT} (orion_chronicles)
🗃️  Cache:         localhost:${REDIS_PORT}

${YELLOW}SERVICES:${NC}
✅ Orion Dashboard:  systemctl status orion-chronicles
✅ PostgreSQL:       docker ps | grep orion-postgres
✅ Redis:            docker ps | grep orion-redis
✅ Monitoring:       docker ps | grep orion-prometheus

${YELLOW}MANAGEMENT COMMANDS:${NC}
📁 View logs:        journalctl -u orion-chronicles -f
🔄 Restart app:      systemctl restart orion-chronicles
🔧 Backup data:      ${ORION_HOME}/deploy/backup.sh
⚡ Stop everything:  ${ORION_HOME}/deploy/shutdown.sh

${YELLOW}NEXT STEPS:${NC}
1. Configure API keys in ${ORION_HOME}/.env
2. Access the dashboard at http://localhost:${APP_PORT}
3. Create your first user session
4. Start planting seeds on the Mycelial Highway!

${GREEN}The Orion Chronicles are now live!${NC}
EOF
else
    log_error "Failed to start Orion Chronicles"
    journalctl -u orion-chronicles -n 50 --no-pager
    exit 1
fi

# ==================== SHUTDOWN SCRIPT ====================
cat > "${ORION_HOME}/deploy/shutdown.sh" << 'EOF'
#!/bin/bash
echo "Shutting down Orion Chronicles..."

# Stop application
systemctl stop orion-chronicles.service
systemctl disable orion-chronicles.service

# Stop containers
docker stop orion-prometheus orion-postgres-exporter orion-redis-exporter 2>/dev/null
docker stop orion-postgres orion-redis 2>/dev/null

# Remove containers
docker rm orion-prometheus orion-postgres-exporter orion-redis-exporter 2>/dev/null
docker rm orion-postgres orion-redis 2>/dev/null

# Remove network
docker network rm orion-network 2>/dev/null

echo "Orion Chronicles has been shut down."
echo "Note: Data is preserved in ${ORION_HOME}/data/"
EOF

chmod +x "${ORION_HOME}/deploy/shutdown.sh"

log_success "Deployment complete! Orion Chronicles v3.0 is ready."