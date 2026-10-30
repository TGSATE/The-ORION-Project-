cat > launch_orion.sh << 'EOF'
#!/bin/bash
echo "🚀 ORION CHRONICLES DEPLOYMENT"
echo "================================"

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    brew install python3  # or apt-get install python3
fi

# Create and activate virtual environment
python3 -m venv orion_env
source orion_env/bin/activate

# Install dependencies
pip install --upgrade pip
pip install streamlit redis aiohttp sqlalchemy psycopg2-binary

# Initialize SQLite database
python3 -c "
import sqlite3
conn = sqlite3.connect('mycelium_vault.db')
print('✅ Database initialized: mycelium_vault.db')
conn.close()
"

# Start Redis (if not running)
if ! redis-cli ping &> /dev/null; then
    echo "⚠️  Redis not running. Starting..."
    brew services start redis  # or sudo systemctl start redis
    sleep 2
fi

# Launch dashboard
echo "🌌 Launching Player Lobby Console..."
echo "📡 Open browser to: http://localhost:8501"
streamlit run player_lobby.py --server.port 8501
EOF

chmod +x launch_orion.sh
./launch_orion.sh