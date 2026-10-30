#!/bin/bash
# Orion Chronicles v5.1 - Fixed Launch Script

echo "========================================="
echo "   ORION CHRONICLES v5.1 - BLACKOUT FIX"
echo "========================================="

# Create directories
mkdir -p dashboard

# Install requirements
pip install streamlit plotly numpy pandas --quiet

echo ""
echo "✅ Dependencies installed"
echo ""
echo "🚀 Launching Fixed Dashboard..."
echo "🌐 Access at: http://localhost:8511"
echo ""
echo "Key Fixes Applied:"
echo "  ✅ Fixed colorbar title format"
echo "  ✅ Added proper typing imports"  
echo "  ✅ Fixed textarea visibility"
echo "  ✅ Added zero-point field state"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Run the fixed dashboard
streamlit run dashboard/orion_dashboard_v5_1_fixed.py \
    --server.port 8511 \
    --server.headless false \
    --theme.base dark \
    --browser.serverAddress localhost \
    --server.fileWatcherType none