# 1. CREATE VIRTUAL ENVIRONMENT (Recommended)
python -m venv orion_env
source orion_env/bin/activate  # On Windows: orion_env\Scripts\activate

# 2. INSTALL CORE DEPENDENCIES
pip install streamlit redis aiohttp sqlalchemy psycopg2-binary python-dotenv langchain langchain-google-genai

# Optional: For AI model integrations (choose based on your API keys)
pip install openai anthropic groq google-generativeai

# 3. DATABASE INITIALIZATION

# If using PostgreSQL (Recommended for production):
# First, install PostgreSQL if not installed:
# macOS: brew install postgresql
# Ubuntu: sudo apt-get install postgresql

# Create database and user:
sudo -u postgres psql <<EOF
CREATE DATABASE mycelium_vault;
CREATE USER orion_user WITH PASSWORD 'SecurePassword123';
GRANT ALL PRIVILEGES ON DATABASE mycelium_vault TO orion_user;
\c mycelium_vault
CREATE TABLE seeds (
    seed_id VARCHAR(64) PRIMARY KEY,
    original_hash VARCHAR(256) UNIQUE,
    original_text TEXT,
    resonance_vector BYTEA,
    j3_status INTEGER,
    origin_user VARCHAR(128),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_accessed TIMESTAMP,
    trajectory_count INTEGER DEFAULT 0,
    is_complete BOOLEAN DEFAULT FALSE
);
CREATE INDEX idx_resonance ON seeds USING gin(to_tsvector('english', original_text));
EOF

# For SQLite (Development/Testing - simpler):
python -c "
import sqlite3
conn = sqlite3.connect('mycelium_vault.db')
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS seeds (
        seed_id TEXT PRIMARY KEY,
        original_hash TEXT UNIQUE,
        original_text TEXT,
        j3_status INTEGER,
        origin_user TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        last_accessed TIMESTAMP,
        trajectory_count INTEGER DEFAULT 0,
        is_complete BOOLEAN DEFAULT FALSE
    )
''')
cursor.execute('''
    CREATE TABLE IF NOT EXISTS user_resonance (
        user_id TEXT PRIMARY KEY,
        frequency_profile TEXT,
        expertise_tags TEXT,
        contributed_seeds TEXT,
        reputation_score REAL
    )
''')
conn.commit()
conn.close()
print('SQLite database initialized: mycelium_vault.db')
"

# 4. LAUNCH STREAMLIT DASHBOARD
# Create minimal dashboard file first:
cat > player_lobby.py << 'EOF'
import streamlit as st
import asyncio
import redis.asyncio as redis
from datetime import datetime

st.set_page_config(
    page_title="Orion Player Lobby",
    page_icon="🌌",
    layout="wide"
)

# Title
st.title("🌌 ORION PLAYER LOBBY CONSOLE")
st.markdown("**Mycelial Super-Highway Control Panel**")

# Sidebar - User Session
with st.sidebar:
    st.header("🚀 Pilot Console")
    user_id = st.text_input("Captain ID", value="DiamondDriver_001")
    session_status = st.selectbox("Mission Mode", ["Recon", "Debate", "Synthesis", "Highway Patrol"])
    
    if st.button("Initialize Council", type="primary"):
        st.session_state.council_active = True
        st.rerun()

# Main Panels - Three Column Layout
col1, col2, col3 = st.columns(3)

with col1:
    st.subheader("📡 REP Processor")
    raw_input = st.text_area("Enter 144-Level Input:", height=150, 
                           placeholder="Paste your spaghetti brain data here...")
    if st.button("Apply Rind Evaporation"):
        with st.spinner("Processing through REP..."):
            st.info("Seed extracted: 000-level actionable wisdom")

with col2:
    st.subheader("🤝 Council Chamber")
    if 'council_active' in st.session_state:
        st.success("Council Active")
        selected_models = st.multiselect(
            "Activate Pillars:",
            ["Gemini (Ferrari)", "Perplexity (Librarian)", 
             "Claude (Scholar)", "DeepSeek (Engineer)"],
            default=["DeepSeek (Engineer)"]
        )
        
        query = st.text_input("Council Query:")
        if st.button("Convene Council"):
            with st.expander("Back-Chatter Log"):
                st.write("1. Gemini: High-frequency pattern detected")
                st.write("2. Perplexity: Grounded in 3 citations")
                st.write("3. Claude: Narrative coherence confirmed")
                st.write("4. DeepSeek: Structural integrity verified")

with col3:
    st.subheader("🛣️ Mycelial Highway")
    st.metric("Active Seeds", "1,247")
    st.metric("Collaborative Torque", "89%")
    
    if st.button("Browse Seed Vault"):
        with st.expander("Available Seeds"):
            st.write("- Quantum Tunnel Protocol (67% complete)")
            st.write("- Neural Mycelium Mapping (42% complete)")
            st.write("- Ghost Rider Optimization (91% complete)")

# Bottom Status Bar
st.divider()
status_col1, status_col2, status_col3 = st.columns(3)
with status_col1:
    st.caption(f"🟢 Session: {user_id}")
with status_col2:
    st.caption(f"📊 J3 Stability: 99.7%")
with status_col3:
    st.caption(f"🌐 Highway Status: ONLINE")

# Async initialization (simplified)
async def init_redis():
    try:
        r = await redis.from_url("redis://localhost:6379")
        await r.ping()
        return True
    except:
        return False

# Check Redis connection
if st.sidebar.checkbox("Check System Status"):
    redis_status = asyncio.run(init_redis())
    if redis_status:
        st.sidebar.success("Redis: Connected")
    else:
        st.sidebar.error("Redis: Not Connected - run: redis-server")

EOF

# 5. START THE DASHBOARD
streamlit run player_lobby.py --server.port 8501 --server.address 0.0.0.0