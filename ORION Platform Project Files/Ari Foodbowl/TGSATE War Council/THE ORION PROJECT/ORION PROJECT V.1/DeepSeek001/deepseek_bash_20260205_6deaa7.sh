# Test Redis
redis-cli ping  # Should return "PONG"

# Test Python imports
python3 -c "import streamlit, redis, aiohttp; print('✅ All imports successful')"

# Check dashboard is running
curl -s http://localhost:8501/_stcore/health | grep "OK"