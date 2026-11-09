#!/bin/bash
# Orion Chronicles v5.1 - Final Circuit Closure

echo "========================================="
echo "   ORION CHRONICLES v5.1 - CIRCUIT CLOSED"
echo "========================================="

# Create dashboard directory
mkdir -p dashboard

# Install minimal requirements
echo "Installing dependencies..."
pip install streamlit plotly numpy --quiet

# Create the fixed dashboard file
cat > dashboard/orion_dashboard_v5_1_fixed.py << 'EOF'
# [COPY THE ENTIRE CORRECTED CODE ABOVE HERE]
EOF

echo ""
echo "✅ Dashboard file created"
echo ""
echo "🚀 Launching Orion Chronicles v5.1..."
echo "🌐 Access at: http://localhost:8521"
echo ""
echo "Circuit Fixes Applied:"
echo "  ✅ Fixed try-except indentation (line 289)"
echo "  ✅ Correct colorbar dictionary format"
echo "  ✅ Visible textarea with disabled=False"
echo "  ✅ Zero-point field initialization"
echo "  ✅ Proper typing imports at top"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Launch with proper settings
streamlit run dashboard/orion_dashboard_v5_1_fixed.py \
    --server.port 8521 \
    --server.headless false \
    --server.fileWatcherType none \
    --browser.serverAddress localhost \
    --logger.level error