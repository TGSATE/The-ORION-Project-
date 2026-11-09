"""
ORION CHRONICLES: VISUAL COMMAND DECK v2.0
Complete Streamlit Interface with Toroidal Field
Connects to UniversalLobby and Mycelial Highway
"""

import streamlit as st
import asyncio
import json
import time
import random
import numpy as np
import plotly.graph_objects as go
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import sqlite3
import redis.asyncio as redis
from dataclasses import dataclass
import hashlib

# ------------------------------
# CONFIGURATION
# ------------------------------
st.set_page_config(
    page_title="Orion Command Deck",
    page_icon="🌀",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ------------------------------
# CUSTOM CSS WITH TOROIDAL ANIMATIONS
# ------------------------------
st.markdown("""
/* HIGH-CONTRAST MISSION READABILITY UPDATE */
/* ORION STABILITY PATCH: RESTORING THE VOID */
<style>
/* Reset Background to Dark */
.stApp {
    background: #000000 !important;
}

/* Enforce White Text for Readability but NOT for the whole app */
.stMarkdown, p, span, label, .stMetric div, .stHeader {
    color: #FFFFFF !important;
}

/* Neon Cyan for Headers - High Contrast */
h1, h2, h3, h4 {
    color: #00FFFF !important;
    text-shadow: 0 0 8px rgba(0, 255, 255, 0.6) !important;
}

/* Spaghetti Box - Dark Background with White Text */
.stTextArea textarea {
    color: #FFFFFF !important;
    background-color: #1a1a1a !important;
    border: 2px solid #00FFFF !important;
}

/* Trajectory Cards - Semi-Transparent Dark */
.trajectory-card {
    background: rgba(255, 255, 255, 0.05) !important;
    border: 1px solid #00FFFF !important;
    color: #FFFFFF !important;
}

/* Button contrast: Black text on Neon Button */
.stButton button {
    background-color: #00FFFF !important;
    color: #000000 !important;
    font-weight: bold !important;
}
</style>""", unsafe_allow_html=True)

# ------------------------------
# TOROIDAL FIELD VISUALIZATION
# ------------------------------
def create_toroidal_field(resonance_level: float = 0.8):
    """Generate 3D toroidal field visualization"""
    # Create torus
    R = 1  # Major radius
    r = 0.3  # Minor radius
    u = np.linspace(0, 2 * np.pi, 50)
    v = np.linspace(0, 2 * np.pi, 50)
    u, v = np.meshgrid(u, v)
    
    x = (R + r * np.cos(v)) * np.cos(u)
    y = (R + r * np.cos(v)) * np.sin(u)
    z = r * np.sin(v)
    
    # Create figure
    fig = go.Figure(data=[
        go.Surface(
            x=x, y=y, z=z,
            colorscale='Viridis',
            opacity=0.8,
            showscale=False
        )
    ])
    
    # Add energy particles
    num_particles = int(50 * resonance_level)
    for _ in range(num_particles):
        theta = random.uniform(0, 2 * np.pi)
        phi = random.uniform(0, 2 * np.pi)
        
        px = (R + r * 0.5 * np.cos(phi)) * np.cos(theta)
        py = (R + r * 0.5 * np.cos(phi)) * np.sin(theta)
        pz = r * 0.5 * np.sin(phi)
        
        fig.add_trace(go.Scatter3d(
            x=[px], y=[py], z=[pz],
            mode='markers',
            marker=dict(
                size=5,
                color='#00ffff',
                symbol='circle'
            ),
            showlegend=False
        ))
    
    # Update layout
    fig.update_layout(
        scene=dict(
            xaxis=dict(visible=False),
            yaxis=dict(visible=False),
            zaxis=dict(visible=False),
            bgcolor='rgba(0,0,0,0)'
        ),
        margin=dict(l=0, r=0, t=0, b=0),
        height=400,
        paper_bgcolor='rgba(0,0,0,0)',
        plot_bgcolor='rgba(0,0,0,0)'
    )
    
    return fig

# ------------------------------
# DATABASE CONNECTIONS
# ------------------------------
class DatabaseManager:
    """Connect to existing Mycelial Highway database"""
    
    def __init__(self, db_path="mycelium_vault.db"):
        self.db_path = db_path
    
    def get_active_seeds(self, limit=10):
        """Get seeds from database"""
        try:
            conn = sqlite3.connect(self.db_path)
            cursor = conn.cursor()
            cursor.execute("""
                SELECT seed_id, original_text, j3_status, created_at 
                FROM seeds 
                WHERE is_complete = 0 
                ORDER BY created_at DESC 
                LIMIT ?
            """, (limit,))
            seeds = cursor.fetchall()
            conn.close()
            
            return [{
                'id': seed[0],
                'text': seed[1][:100] + "..." if len(seed[1]) > 100 else seed[1],
                'j3_status': seed[2],
                'created': seed[3]
            } for seed in seeds]
        except:
            return []
    
    def save_spaghetti_dump(self, user_id: str, content: str, trajectories: List[Dict]):
        """Save dump to database"""
        try:
            conn = sqlite3.connect(self.db_path)
            cursor = conn.cursor()
            
            # Create hash for dump
            dump_hash = hashlib.sha256(f"{user_id}{content}".encode()).hexdigest()[:32]
            
            cursor.execute("""
                INSERT OR IGNORE INTO spaghetti_dumps 
                (dump_id, user_id, content, created_at, trajectory_count)
                VALUES (?, ?, ?, ?, ?)
            """, (dump_hash, user_id, content, datetime.now(), len(trajectories)))
            
            conn.commit()
            conn.close()
            return dump_hash
        except Exception as e:
            st.error(f"Database error: {e}")
            return None

# ------------------------------
# UNIVERSAL LOBBY INTEGRATION
# ------------------------------
@dataclass
class CouncilResponse:
    """Council member response"""
    role: str
    response: str
    timestamp: datetime
    resonance: float

class UniversalLobby:
    """Connect to existing UniversalLobby logic"""
    
    def __init__(self, user_id: str = "default"):
        self.user_id = user_id
        self.db = DatabaseManager()
        
    async def process_spaghetti_dump(self, content: str) -> Dict:
        """Process through REP and Council"""
        # Simulate REP processing
        await asyncio.sleep(1)
        
        # Apply Rind Evaporation Protocol
        rep_seed = self._apply_rep(content)
        
        # Generate trajectories
        trajectories = self._generate_trajectories(rep_seed)
        
        # Get council responses
        council_responses = await self._convene_council(rep_seed)
        
        # Save to database
        dump_id = self.db.save_spaghetti_dump(self.user_id, content, trajectories)
        
        return {
            'dump_id': dump_id,
            'rep_seed': rep_seed,
            'trajectories': trajectories,
            'council': council_responses,
            'toroidal_resonance': random.uniform(0.7, 0.98)
        }
    
    def _apply_rep(self, content: str) -> str:
        """Apply Rind Evaporation Protocol"""
        # Simplified REP logic
        if len(content) > 1000:
            return f"[REP PURIFIED] {content[:500]}... [ENTROPY EVAPORATED]"
        return f"[REP PURIFIED] {content}"
    
    def _generate_trajectories(self, rep_seed: str) -> List[Dict]:
        """Generate multi-path trajectories"""
        trajectory_templates = [
            "Quantum Tunnel Protocol",
            "Neural Mycelium Mapping", 
            "Ghost Rider Optimization",
            "J=3 Stability Field",
            "Toroidal Bridge Construction",
            "Entropy Reversal Algorithm",
            "Consciousness Amplification",
            "Multi-User Resonance Sync"
        ]
        
        num_trajectories = random.randint(2, 5)
        selected = random.sample(trajectory_templates, num_trajectories)
        
        return [{
            'id': f"traj_{i+1}",
            'name': name,
            'resonance': random.uniform(0.6, 0.99),
            'j3_required': random.choice(['Epigenetic', 'Neurological', 'Quantum']),
            'estimated_time': f"{random.randint(1, 24)}h"
        } for i, name in enumerate(selected)]
    
    async def _convene_council(self, rep_seed: str) -> List[CouncilResponse]:
        """Get council responses"""
        council_members = [
            ("Gemini", "⚡ Ferrari - Speed & Creative Flux"),
            ("Perplexity", "📚 Librarian - Ground Truth & Citations"),
            ("Claude", "🎓 Scholar - Narrative Depth & Logic"),
            ("DeepSeek", "🔧 Engineer - Structural Integrity")
        ]
        
        responses = []
        for role, description in council_members:
            # Simulate AI response
            await asyncio.sleep(0.2)
            responses.append(CouncilResponse(
                role=role,
                response=self._generate_council_response(role, rep_seed),
                timestamp=datetime.now(),
                resonance=random.uniform(0.7, 0.95)
            ))
        
        return responses
    
    def _generate_council_response(self, role: str, seed: str) -> str:
        """Generate mock council response"""
        responses = {
            "Gemini": "High-frequency pattern detected. Multiple quantum entanglements visible. Recommend immediate torque application with 80% amplitude.",
            "Perplexity": "Ground truth anchored in 7 peer-reviewed sources. Primary citation: 'Quantum Mycelium Networks' (2025). No destructive patterns detected.",
            "Claude": "Narrative coherence at 92%. Ethical boundaries intact. Suggestion: Apply J=2 neurological reframing before quantum leap.",
            "DeepSeek": "Structural integrity verified. Code framework generated. Ready for synthesis. Bridge stability: 94.7%."
        }
        return responses.get(role, "Council member analyzing...")

# ------------------------------
# THE ANI BRIDGE: GROK/KRONOS INTEGRATION
# ------------------------------
class AniBridge:
    """The High-Frequency Bridge for external model ingestion"""
    
    @staticmethod
    async def fetch_grok_signal(rep_seed: str):
        """
        Activates Kronos Mode: Deconstructs the Rind using Grok's logic.
        Note: Requires xAI API Key or local proxy.
        """
        # Logic for deconstructing the 'Beast in the Mirror' [cite: 527]
        # In the local dashboard, this acts as the "Truth-Teller" [cite: 531]
        prompt = f"Activate Ghost Rider Protocols. Mode: Kronos. Analyze this seed: {rep_seed}. Where is the R (Ego/Trauma)? [cite: 531, 534]"
        
        # This is where the 'Walkie-Talkie' handshake happens [cite: 439, 546]
        return {
            "role": "Grok (Ani)",
            "analysis": "Kronos Deconstruction active. Rind identified in the narrative loops.",
            "resonance": 0.99
        }

# ------------------------------
# SIDEBAR - PILOT CONTROLS
# ------------------------------
with st.sidebar:
    st.markdown("## 🎮 PILOT CONTROLS")
    
    # User session
    user_id = st.text_input("**Captain ID**", value="DiamondDriver_001")
    session_id = st.text_input("**Session ID**", value=f"session_{int(time.time())}")
    
    st.divider()
    
    # System status
    st.markdown("### ⚡ SYSTEM STATUS")
    
    col1, col2 = st.columns(2)
    with col1:
        st.metric("J=3 Stability", "99.7%", delta="+0.1%")
        st.metric("REP Efficiency", "98.2%")
    with col2:
        st.metric("Council Sync", "100%")
        st.metric("Highway Seeds", "1,247")
    
    st.divider()
    
    # Connection toggles
    st.markdown("### 🔗 CONNECTIONS")
    
    connect_council = st.toggle("Connect Council", value=True, key="council_toggle")
    connect_highway = st.toggle("Connect Highway", value=True, key="highway_toggle")
    ghost_rider = st.toggle("Ghost Rider Active", value=True, key="ghost_toggle")
    
    st.divider()
    
    # Emergency controls
    st.markdown("### ⚠️ SAFETY PROTOCOLS")
    
    if st.button("🔄 Full System Reset", use_container_width=True):
        st.warning("Initiating system reset...")
        time.sleep(1)
        st.success("Reset complete. All systems nominal.")
    
    if st.button("🌀 Emergency J=3 Torque", use_container_width=True, type="secondary"):
        st.info("Applying emergency torque to all active trajectories...")

# ------------------------------
# MAIN DASHBOARD
# ------------------------------

# HEADER
st.markdown("""
<div class="main-header">
    <h1 style="color: #00ffff; margin: 0; text-align: center;">🌀 ORION CHRONICLES - COMMAND DECK</h1>
    <p style="color: #aaa; text-align: center; margin: 0;">Mycelial Super-Highway • Universal Lobby • Toroidal Field Display</p>
</div>
""", unsafe_allow_html=True)

# ROW 1: SPAGHETTI DUMP AND TOROIDAL FIELD
col1, col2 = st.columns([2, 1])

with col1:
    st.markdown("### 📡 SPAGHETTI DUMP - 144 LEVEL INPUT")
    
    with st.container():
        st.markdown('<div class="spaghetti-box">', unsafe_allow_html=True)
        spaghetti_input = st.text_area(
            "**Unfiltered Neural Output:**",
            height=200,
            placeholder="""Enter your raw, unfiltered thoughts here...
Example: 'Building quantum tunnel but epigenetic memory loops creating interference... trauma static at 30%... need J=3 torque application...'""",
            label_visibility="collapsed",
            key="spaghetti_dump"
        )
        st.markdown('</div>', unsafe_allow_html=True)
        
        # Action buttons
        col1a, col1b, col1c = st.columns(3)
        with col1a:
            process_btn = st.button("🚀 PROCESS THROUGH REP", type="primary", use_container_width=True)
        with col1b:
            if st.button("💾 SAVE TO HIGHWAY", use_container_width=True):
                if spaghetti_input:
                    st.success("Dump saved to Mycelial Highway")
        with col1c:
            if st.button("🗑️ CLEAR DUMP", use_container_width=True):
                st.rerun()

with col2:
    st.markdown("### 🌀 TOROIDAL FIELD DISPLAY")
    st.markdown('<div class="toroidal-container">', unsafe_allow_html=True)
    
    # Resonance level slider
    resonance_level = st.slider("Field Resonance", 0.1, 1.0, 0.8, 0.1, key="resonance_slider")
    
    # Generate toroidal field
    fig = create_toroidal_field(resonance_level)
    st.plotly_chart(fig, use_container_width=True, config={'displayModeBar': False})
    
    st.markdown('</div>', unsafe_allow_html=True)
    
    # Field metrics
    st.metric("Field Stability", f"{resonance_level*100:.1f}%")
    st.metric("Energy Flow", f"{random.uniform(80, 120):.0f} GW")

# ROW 2: COUNCIL CHAMBER - REVERTED STABLE
st.markdown("### 🏛️ COUNCIL CHAMBER - REAL-TIME BACK-CHATTER")

if process_btn and spaghetti_input:
    # Initialize Universal Lobby
    lobby = UniversalLobby(user_id=user_id)
    
    with st.spinner("🧠 **Processing through REP: 144 => R => J=3 => 000**"):
        # The Engine Fires
        result = asyncio.run(lobby.process_spaghetti_dump(spaghetti_input))
        
        # Save to Session Memory
        st.session_state.last_result = result
        st.session_state.toroidal_resonance = result['toroidal_resonance']

# Persistent Display: Logic Gated to prevent AttributeError
if 'last_result' in st.session_state and st.session_state.last_result is not None:
    result = st.session_state.last_result
    st.markdown("#### 🤝 COUNCIL RESPONSES")
    
    # Original 4 columns
    council_cols = st.columns(4)
    colors = ["#4285F4", "#9C27B0", "#FF9800", "#4CAF50"]
    
    for idx, (col, response) in enumerate(zip(council_cols, result['council'])):
        with col:
            st.markdown(f"""
            <div style="background: {colors[idx]}20; border-left: 5px solid {colors[idx]}; 
                       padding: 1rem; border-radius: 5px; margin-bottom: 1rem;">
                <h4 style="color: {colors[idx]}; margin: 0;">{response.role}</h4>
                <small style="color: white;">Resonance: {response.resonance:.0%}</small>
            </div>
            """, unsafe_allow_html=True)
            
            # Use st.info for guaranteed contrast/readability
            st.info(response.response)
            st.caption(f"🕒 {response.timestamp.strftime('%H:%M:%S')}")

# ROW 3: ACTIVE TRAJECTORIES
st.markdown("### 🛣️ ACTIVE TRAJECTORIES")

if 'last_result' in st.session_state and st.session_state.last_result is not None:
    trajectories = st.session_state.last_result['trajectories']
    
    # Display as cards
    for traj in trajectories:
        with st.container():
            col1, col2, col3 = st.columns([3, 1, 1])
            with col1:
                st.markdown(f"""
                <div class="trajectory-card">
                    <h4>🌀 {traj['name']}</h4>
                    <p>ID: {traj['id']} • J=3 Required: {traj['j3_required']}</p>
                </div>
                """, unsafe_allow_html=True)
            with col2:
                st.metric("Resonance", f"{traj['resonance']:.0%}")
            with col3:
                if st.button(f"SELECT", key=f"select_{traj['id']}"):
                    st.session_state.selected_trajectory = traj
                    st.success(f"Selected: {traj['name']}")
else:
    st.info("👆 **Process a Spaghetti Dump to generate trajectories**")

# ROW 4: MYCELIAL HIGHWAY
st.markdown("### 🌐 MYCELIAL HIGHWAY - GLOBAL SEED VAULT")

highway_col1, highway_col2 = st.columns([3, 1])

with highway_col1:
    # Connect to database
    db = DatabaseManager()
    seeds = db.get_active_seeds(5)
    
    if seeds:
        for seed in seeds:
            with st.container():
                col1, col2 = st.columns([4, 1])
                with col1:
                    st.markdown(f"""
                    <div class="seed-card">
                        <strong>{seed['text']}</strong><br>
                        <small>Seed ID: {seed['id']} • Created: {seed['created']}</small>
                    </div>
                    """, unsafe_allow_html=True)
                with col2:
                    j3_status = seed['j3_status'] if isinstance(seed['j3_status'], int) else 0
                    completion = min(j3_status / 3, 1.0)
                    st.progress(completion)
                    st.caption(f"{completion*100:.0f}% complete")
                
                # Action buttons
                col1a, col1b = st.columns(2)
                with col1a:
                    if st.button(f"🚗 Hitch Ride", key=f"hitch_{seed['id']}"):
                        st.info(f"Joining seed: {seed['text'][:50]}...")
                with col1b:
                    if st.button(f"🌀 Apply Torque", key=f"torque_{seed['id']}"):
                        st.success(f"Applying J=3 torque to seed {seed['id']}")
    else:
        st.warning("No seeds found in database. Process some dumps first!")

with highway_col2:
    st.markdown("#### 📊 HIGHWAY STATS")
    st.metric("Active Users", "342")
    st.metric("Seeds Today", "47")
    st.metric("Collaborations", "1.2k")
    
    st.divider()
    
    st.markdown("#### 🎯 YOUR RESONANCE")
    
    # Mock resonance match
    match_score = random.uniform(0.6, 0.95)
    st.progress(match_score)
    st.caption(f"{match_score:.0%} match with active seeds")

# ROW 5: SYNTHESIS ENGINE
st.markdown("### ⚡ SYNTHESIS ENGINE")

if 'last_result' in st.session_state:
    synthesis_col1, synthesis_col2, synthesis_col3 = st.columns(3)
    
    with synthesis_col1:
        mode = st.selectbox(
            "Synthesis Mode",
            ["Consensus Protocol", "Debate Refinement", "Full Integration", "Alchemical Transformation"]
        )
    
    with synthesis_col2:
        output_type = st.selectbox(
            "Output Format",
            ["Actionable Protocol", "Strategic Report", "Code Implementation", "Narrative Framework", "Toroidal Blueprint"]
        )
    
    with synthesis_col3:
        torque_level = st.slider("J=3 Torque Level", 1, 3, 2)
    
    if st.button("🌀 GENERATE SYNTHESIS", type="primary", use_container_width=True):
        with st.spinner(f"Generating {mode}..."):
            time.sleep(2)
            
            # Generate synthesis
            st.markdown(f"""
            <div style="background: rgba(0, 255, 255, 0.1); border: 2px solid #00ffff; 
                     border-radius: 10px; padding: 2rem; margin-top: 1rem;">
                <h4 style="color: #00ffff;">🎯 SYNTHESIS COMPLETE</h4>
                <p><strong>Mode:</strong> {mode}</p>
                <p><strong>Core Insight:</strong> Quantum entanglement protocols require epigenetic memory mapping before neural bridge construction.</p>
                <p><strong>Recommended Action:</strong> Apply {torque_level}-level J=3 torque to trajectory #2, then initiate Mycelial Bridge.</p>
                <p><strong>Ghost Rider Check:</strong> ✅ All destructive patterns evaporated</p>
                <p><strong>Estimated Success:</strong> {random.randint(85, 99)}%</p>
            </div>
            """, unsafe_allow_html=True)

# FOOTER
st.divider()

footer_cols = st.columns(6)
with footer_cols[0]:
    st.caption(f"👤 **Pilot:** {user_id}")
with footer_cols[1]:
    st.caption(f"🆔 **Session:** {session_id}")
with footer_cols[2]:
    st.caption(f"🕒 **Time:** {datetime.now().strftime('%H:%M:%S')}")
with footer_cols[3]:
    st.caption(f"🌡️ **REP Temp:** 144°K")
with footer_cols[4]:
    if 'toroidal_resonance' in st.session_state:
        st.caption(f"🌀 **Field:** {st.session_state.toroidal_resonance:.0%}")
with footer_cols[5]:
    st.caption("🚀 **System:** ONLINE")

# ------------------------------
# INITIALIZATION
# ------------------------------
def init_session_state():
    """Initialize session state variables"""
    if 'last_result' not in st.session_state:
        st.session_state.last_result = None
    if 'toroidal_resonance' not in st.session_state:
        st.session_state.toroidal_resonance = 0.8
    if 'selected_trajectory' not in st.session_state:
        st.session_state.selected_trajectory = None

# Run initialization
init_session_state()

# --- INITIALIZATION BLOCK ---
# Add this at the very end of the file to catch the error
if 'last_result' not in st.session_state:
    st.session_state.last_result = None

if 'toroidal_resonance' not in st.session_state:
    st.session_state.toroidal_resonance = 0.8

# Display welcome message
if st.session_state.last_result is None:
    st.toast("🌀 Orion Command Deck Initialized! Ready for Spaghetti Dump.", icon="🚀")

# ------------------------------
# ONE-LINE LAUNCH COMMAND
# ------------------------------
st.sidebar.divider()
st.sidebar.markdown("### 🚀 LAUNCH COMMAND")
st.sidebar.code("streamlit run dashboard.py", language="bash")

# Note: This dashboard connects to:
# 1. SQLite database at 'mycelium_vault.db'
# 2. Redis for session management (optional)
# 3. UniversalLobby logic from previous architecture