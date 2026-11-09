#!/bin/bash
# Orion Chronicles v5.0 Launch Script

echo "========================================="
echo "   ORION CHRONICLES v5.0 LAUNCH SEQUENCE"
echo "========================================="

# Create directory structure
mkdir -p {core,dashboard,data}

# Check Python
if ! command -v python3.10 &> /dev/null; then
    echo "⚠️ Python 3.10+ required"
    exit 1
fi

# Create virtual environment
if [ ! -d "venv_v5" ]; then
    python3.10 -m venv venv_v5
    echo "✅ Virtual environment created"
fi

# Activate and install dependencies
source venv_v5/bin/activate
pip install --upgrade pip
pip install -r requirements_v5.txt

# Create core module
if [ ! -f "core/orion_engine_v5.py" ]; then
    echo "Creating Orion Engine v5.0..."
    # Copy the engine code from above
    cat > core/orion_engine_v5.py << 'EOF'
# [PASTE THE COMPLETE orion_engine_v5.py CODE HERE]
EOF
    echo "✅ Engine v5.0 created"
fi

# Create dashboard
if [ ! -f "dashboard/orion_dashboard_v5.py" ]; then
    echo "Creating Dashboard v5.0..."
    # Copy the dashboard code from above
    cat > dashboard/orion_dashboard_v5.py << 'EOF'
# [PASTE THE COMPLETE orion_dashboard_v5.py CODE HERE]
EOF
    echo "✅ Dashboard v5.0 created"
fi

# Launch
echo ""
echo "🚀 Launching Orion Chronicles v5.0..."
echo "🌐 Dashboard will open at: http://localhost:8505"
echo ""
echo "Press Ctrl+C to stop"
echo ""

streamlit run dashboard/orion_dashboard_v5.py \
    --server.port 8505 \
    --server.headless false \
    --theme.base dark \
    --browser.serverAddress localhost