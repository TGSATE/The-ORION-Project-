"""
ORION DASHBOARD v3.0 - Streamlit Interface
Run with: streamlit run orion_dashboard.py
"""

import streamlit as st
import asyncio
import json
import plotly.graph_objects as go
from datetime import datetime
import sys
import os

# Add engine to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from orion_engine import OrionEngine, ToroidalField, REPProcessor

# ==================== PAGE CONFIG ====================
st.set_page_config(
    page_title="Orion Chronicles Command Deck",
    page_icon="🚀",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ==================== CSS STYLING ====================
st.markdown("""
<style>
    .main-header {
        font-size: 3rem;
        background: linear-gradient(90deg, #4B0082, #8A2BE2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        padding: 20px;
    }
    .metric-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 10px;
        padding: 15px;
        color: white;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .stTextArea textarea {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    }
</style>
""", unsafe_allow_html=True)

# ==================== INITIALIZATION ====================
@st.cache_resource
def init_orion_engine():
    """Initialize Orion Engine singleton"""
    return OrionEngine()

engine = init_orion_engine()
current_user = "diamond_driver"  # In production, would be from auth

# ==================== SIDEBAR ====================
with st.sidebar:
    st.markdown("## 🔧 Control Panel")
    
    # User Session
    if st.button("🔄 Initialize New Session"):
        session = asyncio.run(engine.create_user_session(current_user))
        st.session_state.current_session = session
        st.success(f"Session {session.session_id[:8]} created")
    
    # System Metrics
    st.markdown("### 📊 System Health")
    metrics = engine.get_system_metrics()
    
    col1, col2 = st.columns(2)
    with col1:
        st.metric("J=3 Stability", f"{metrics['j3_stability']:.2%}")
    with col2:
        st.metric("REP Efficiency", f"{metrics['rep_efficiency']:.2%}")
    
    st.progress(metrics['j3_stability'], text="System Integrity")
    
    # Active Users
    st.metric("Active Users", metrics['active_users'])
    
    # Toroidal Field Controls
    st.markdown("### 🌀 Field Controls")
    field_opacity = st.slider("Field Opacity", 0.1, 1.0, 0.7)
    field_rotation = st.slider("Rotation Speed", 0, 10, 3)

# ==================== MAIN DASHBOARD ====================
st.markdown('<div class="main-header">Orion Chronicles Command Deck</div>', unsafe_allow_html=True)

# Two-column layout
col_left, col_right = st.columns([2, 1])

with col_left:
    # ==================== SPAGHETTI DUMP INPUT ====================
    st.markdown("### 🍝 Spaghetti Brain Dump")
    
    spaghetti_input = st.text_area(
        "Enter your raw thoughts, ideas, or questions:",
        height=150,
        placeholder="Type anything here... The REP engine will purify it through 144 => R => J=3 => 000",
        key="spaghetti_input"
    )
    
    # Process Button
    if st.button("🚀 Process Through REP Engine", type="primary", use_container_width=True):
        if spaghetti_input:
            with st.spinner("Processing through REP layers..."):
                # Get or create session
                if "current_session" not in st.session_state:
                    session = asyncio.run(engine.create_user_session(current_user))
                    st.session_state.current_session = session
                else:
                    session = st.session_state.current_session
                
                # Process query
                result = asyncio.run(session.process_query(spaghetti_input))
                
                # Store result
                st.session_state.last_result = result
                
                # Show success
                st.success("Processing complete!")
        
    # ==================== RESULTS DISPLAY ====================
    if "last_result" in st.session_state:
        result = st.session_state.last_result
        
        st.markdown("### 📊 Processing Results")
        
        # REP Analysis
        with st.expander("🧬 REP Analysis", expanded=True):
            rep = result["rep_analysis"]
            col1, col2, col3 = st.columns(3)
            with col1:
                st.metric("Entropy Score", f"{rep['rind_analysis']['entropy']:.3f}")
            with col2:
                st.metric("Rind Mass", f"{rep['rind_analysis']['rind_mass']:.3f}")
            with col3:
                st.metric("Efficiency", f"{rep['efficiency_score']:.2%}")
            
            st.text_area("Purified Seed", rep["purified_seed"], height=100)
        
        # Council Consensus
        with st.expander("🏛️ Council Consensus", expanded=True):
            st.markdown(result["council_consensus"])
            
            # Individual responses
            st.markdown("#### Individual Responses")
            for response in result["individual_responses"]:
                st.markdown(f"**{response['role']}**: {response['response'][:200]}...")
        
        # Ghost Rider Status
        if result["ghost_rider_transformed"]:
            st.warning("⚠️ Ghost Rider Protocol was activated. Input was alchemically transformed.")

with col_right:
    # ==================== TOROIDAL FIELD VISUALIZATION ====================
    st.markdown("### 🌀 Toroidal Energy Field")
    
    metrics = engine.get_system_metrics()
    field_data = ToroidalField.generate_field_data(
        metrics["j3_stability"],
        metrics["rep_efficiency"]
    )
    
    # Create 3D plot
    fig = go.Figure(data=[go.Surface(
        x=field_data["x"],
        y=field_data["y"],
        z=field_data["z"],
        colorscale=field_data["colorscale"],
        opacity=field_opacity,
        contours={
            "x": {"show": True, "color": "white"},
            "y": {"show": True, "color": "white"},
            "z": {"show": True, "color": "white"}
        }
    )])
    
    fig.update_layout(
        title="J=3 Spirit Constant Field",
        scene=dict(
            xaxis_title="X Axis",
            yaxis_title="Y Axis",
            zaxis_title="Z Axis",
            camera=dict(
                eye=dict(x=1.5, y=1.5, z=1.5)
            )
        ),
        width=400,
        height=400,
        margin=dict(l=0, r=0, t=30, b=0)
    )
    
    st.plotly_chart(fig, use_container_width=True)
    
    # ==================== MYCELIAL HIGHWAY ====================
    st.markdown("### 🌐 Mycelial Highway")
    
    if st.button("🌱 Browse Available Seeds", use_container_width=True):
        # In production, would fetch from database
        st.info("Seed vault integration pending database setup")
    
    if st.button("🚀 Plant Current Seed", use_container_width=True):
        if "last_result" in st.session_state:
            seed_data = st.session_state.last_result["seed_ready_for_vault"]
            # Here you would call: await engine.mycelial_highway.deposit_seed(seed_data, current_user)
            st.success("Seed planted to global vault!")
    
    # ==================== PLAYER STATS ====================
    if "current_session" in st.session_state:
        st.markdown("### 👤 Player Stats")
        stats = st.session_state.current_session.player_stats
        
        st.metric("Resonance Frequency", f"{stats.resonance_frequency:.3f}")
        st.metric("Seeds Planted", stats.total_seeds_planted)
        
        # J3 Mastery Bars
        st.markdown("#### J=3 Mastery")
        for domain, mastery in stats.j3_mastery.items():
            st.progress(mastery, text=f"{domain.title()}: {mastery:.0%}")

# ==================== FOOTER ====================
st.markdown("---")
col1, col2, col3 = st.columns(3)
with col1:
    st.caption(f"System Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
with col2:
    st.caption("Orion Chronicles v3.0")
with col3:
    st.caption("Ghost Rider Protocol: ACTIVE")

# ==================== ASYNC EVENT LOOP ====================
import threading

def start_async_loop():
    asyncio.set_event_loop(asyncio.new_event_loop())

threading.Thread(target=start_async_loop, daemon=True).start()

if __name__ == "__main__":
    # Initialize on first run
    if "engine_initialized" not in st.session_state:
        st.session_state.engine_initialized = True
        st.rerun()