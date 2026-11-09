#!/bin/bash
# Orion Chronicles v5.1 Launch Script

echo "========================================="
echo "   ORION CHRONICLES v5.1 LAUNCH"
echo "   Visual Re-entry & Insight Balancing"
echo "========================================="

# Create directories
mkdir -p {core,dashboard,data}

# Check Python
if ! command -v python3.10 &> /dev/null; then
    echo "⚠️ Python 3.10+ required"
    exit 1
fi

# Create virtual environment
if [ ! -d "venv_v5_1" ]; then
    python3.10 -m venv venv_v5_1
    echo "✅ Virtual environment created"
fi

# Activate and install
source venv_v5_1/bin/activate
pip install --upgrade pip
pip install streamlit plotly numpy pandas

# Save engine file
echo "Creating Orion Engine v5.1..."
cat > core/orion_engine_v5_1.py << 'EOF'
# [PASTE THE COMPLETE orion_engine_v5_1.py CODE HERE]
EOF

# Save dashboard file  
echo "Creating Dashboard v5.1..."
cat > dashboard/orion_dashboard_v5_1.py << 'EOF'
# [PASTE THE COMPLETE orion_dashboard_v5_1.py CODE HERE]
EOF

echo ""
echo "✅ v5.1 System Ready!"
echo ""
echo "🚀 Launching Orion Chronicles v5.1..."
echo "🌐 Dashboard: http://localhost:8510"
echo "🔭 Observation Deck: Full-width visualization"
echo "⚖️ 3+1 Insights: Balanced resonance/anchor display"
echo ""
echo "Press Ctrl+C to stop"
echo ""

streamlit run dashboard/orion_dashboard_v5_1.py \
    --server.port 8510 \
    --server.headless false \
    --theme.base dark \
    --browser.serverAddress localhost