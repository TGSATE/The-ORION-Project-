# If Redis connection fails:
redis-server &  # Start Redis in background

# If port 8501 is busy:
streamlit run player_lobby.py --server.port 8502

# To view logs:
tail -f ~/.streamlit/logs/*.log

# Reset database (SQLite):
rm mycelium_vault.db && python3 -c "import sqlite3; conn=sqlite3.connect('mycelium_vault.db'); conn.close()"