#!/bin/bash
# Orion Chronicles Ignition Script
# Version: 3.0
# Date: 2026-01-05

set -e  # Exit on error

echo "========================================="
echo "   ORION CHRONICLES IGNITION SEQUENCE   "
echo "========================================="

# ==================== CONFIGURATION ====================
ORION_DIR="${ORION_DIR:-$(pwd)}"
VENV_NAME="orion_venv"
PORT="${PORT:-8501}"
DB_NAME="orion_chronicles"
DB_USER="orion_admin"
DB_PASSWORD="$(openssl rand -hex 16)"

# ==================== DEPENDENCIES ====================
echo "[1/6] Checking system dependencies..."

REQUIRED_CMDS=("python3.10" "pip" "git" "docker" "psql")
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        echo "❌ Missing required command: $cmd"
        exit 1
    fi
done

# ==================== VIRTUAL ENVIRONMENT ====================
echo "[2/6] Setting up Python environment..."

if [ ! -d "$VENV_NAME" ]; then
    python3.10 -m venv $VENV_NAME
fi

source $VENV_NAME/bin/activate

# Install Python packages
pip install --upgrade pip
pip install -r requirements.txt

# ==================== DATABASE INITIALIZATION ====================
echo "[3/6] Initializing database..."

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "⚠️ Docker not running. Starting Docker service..."
    sudo systemctl start docker
    sleep 5
fi

# Start PostgreSQL with pgvector
if ! docker ps --format '{{.Names}}' | grep -q "orion-postgres"; then
    echo "Starting PostgreSQL container..."
    docker run -d \
        --name orion-postgres \
        -p 5432:5432 \
        -e POSTGRES_USER=$DB_USER \
        -e POSTGRES_PASSWORD=$DB_PASSWORD \
        -e POSTGRES_DB=$DB_NAME \
        -v orion_data:/var/lib/postgresql/data \
        pgvector/pgvector:pg15
    sleep 10  # Wait for DB to start
fi

# Initialize schema
echo "Creating database schema..."
psql "postgresql://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME" \
    -f "$ORION_DIR/database_schema.sql"

# ==================== ENVIRONMENT VARIABLES ====================
echo "[4/6] Configuring environment..."

cat > .