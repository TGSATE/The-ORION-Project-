"""
ORION CHRONICLES v5.0 DASHBOARD
Complete Streamlit interface for the master integration
"""

import streamlit as st
import asyncio
import json
import plotly.graph_objects as go
from datetime import datetime
import sys
import os
import numpy as np
import traceback
import threading
from typing import Dict, List, Any

# ==================== GLOBAL CONSTANTS ====================
TOROIDAL_BASE_RADIUS = 1.44
J3_SPIRIT_CONSTANT = 3.0
GAIA_FACTOR = 1.5
EDEN_HANDSHAKE_VERSION = "2.0"

# ==================== PAGE CONFIGURATION ====================
st.set_page_config(
    page_title="Orion Chronicles v5.0 Command Deck",
    page_icon="🌀",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ==================== CUSTOM CSS v5.0 ====================
st.markdown("""
<style>
    .main-header {
        font-size: 3.5rem;
        background: linear-gradient(90deg, #667eea 0%, #8A2BE2 50%, #4B0082 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        padding: 20px;
        margin-bottom: 20px;
        font-weight: 900;
        text-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .phase-card {
        background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(138, 43, 226, 0.1) 100%);
        border-radius: 15px;
        padding: 20px;
        margin: 10px 0;
        border-left: 5px solid #8A2BE2;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .seat-card {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
        padding: 15px;
        margin: 8px 0;
        border: 1px solid rgba(138, 43, 226, 0.3);
        transition: all 0.3s ease;
    }
    .seat-card:hover {
        background: rgba(138, 43, 226, 0.1);
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(138, 43, 226, 0.2);
    }
    .trajectory-card {
        background: linear-gradient(135deg, rgba(75, 0, 130, 0.1) 0%, rgba(138, 43, 226, 0.1) 100%);
        border-radius: 10px;
        padding: 20px;
        margin: 15px 0;
        border: 2px solid transparent;
        border-image: linear-gradient(135deg, #667eea, #8A2BE2) 1;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    .trajectory-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(138, 43, 226, 0.3);
    }
    .metric-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        margin: 2px;
    }
    .efficiency-badge { background: linear-gradient(135deg, #4CAF50, #2E7D32); color: white; }
    .entropy-badge { background: linear-gradient(135deg, #FF9800, #F57C00); color: white; }
    .spiritual-badge { background: linear-gradient(135deg, #9C27B0, #7B1FA2); color: white; }
    .stTextArea textarea {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-radius: 10px;
        border: 2px solid #8A2BE2;
        font-size: 16px;
        padding: 15px;
        transition: all 0.3s ease;
    }
    .stTextArea textarea:focus {
        border-color: #4B0082;
        box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
    }
    .engine-status {
        padding: 15px;
        border-radius: 10px;
        text-align: center;
        font-weight: bold;
        margin: 10px 0;
    }
    .engine-online {
        background: linear-gradient(135deg, #4CAF50, #2E7D32);
        color: white;
    }
    .engine-offline {
        background: linear-gradient(135deg, #f44336, #d32f2f);
        color: white;
    }
</style>
""", unsafe_allow_html=True)

# ==================== SESSION STATE INITIALIZATION ====================
if 'current_session' not in st.session_state:
    st.session_state.current_session = None
if 'processing_history' not in st.session_state:
    st.session_state.processing_history = []
if 'selected_trajectory' not in st.session_state:
    st.session_state.selected_trajectory = None
if 'edited_trajectories' not in st.session_state:
    st.session_state.edited_trajectories = {}
if 'user_id' not in st.session_state:
    st.session_state.user_id = f"driver_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
if 'engine_v5' not in st.session_state:
    st.session_state.engine_v5 = None
if 'engine_initialized' not in st.session_state:
    st.session_state.engine_initialized = False
if 'async_thread' not in st.session_state:
    st.session_state.async_thread = None

# ==================== ENGINE INITIALIZATION ====================
@st.cache_resource
def initialize_engine_v5():
    """Initialize Orion Engine v5.0 singleton"""
    try:
        # Add core to path
        core_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'core')
        if core_path not in sys.path:
            sys.path.append(core_path)
        
        # Try to import v5 engine
        try:
            from orion_engine_v5 import get_orion_engine_v5
            engine = get_orion_engine_v5()
            st.success("✅ Orion Engine v5.0 Initialized!")
            return engine, None
        except ImportError:
            # Fallback to local definition
            st.warning("⚠️ Using inline Orion Engine v5.0")
            
            # Create minimal engine
            class MinimalOrionEngineV5:
                def __init__(self):
                    self.session_counter = 0
                
                async def process_spaghetti_dump(self, raw_input: str):
                    self.session_counter += 1
                    
                    # Simulate processing
                    await asyncio.sleep(1)
                    
                    return {
                        "session_id": f"MINIMAL-{self.session_counter:04d}",
                        "timestamp": datetime.utcnow().isoformat(),
                        "pipeline_version": "5.0-minimal",
                        "ghost_rider_report": {
                            "activated": "destroy" in raw_input.lower(),
                            "severity_score": 0.5 if "destroy" in raw_input.lower() else 0.0
                        },
                        "watermelon_analysis": {
                            "is_144_aligned": "144" in raw_input,
                            "watermelon_frequency": 75.0
                        },
                        "transmutation_report": {
                            "is_transmuted": True,
                            "transmutation_efficiency": 0.85
                        },
                        "council_report": {
                            "council_metrics": {
                                "average_confidence": 0.88,
                                "seat_alignment": 0.92
                            },
                            "consensus_report": {
                                "primary_consensus": "Council analysis complete. Proceed with quantum-mycelial integration.",
                                "confidence_score": 0.88
                            },
                            "alternative_trajectories": [
                                {
                                    "id": "TRJ-001",
                                    "name": "Spiritual Quantum Leap",
                                    "description": "Focus on spiritual expansion and consciousness integration.",
                                    "editable_fields": ["description", "focus_areas"],
                                    "estimated_efficiency": 0.85
                                },
                                {
                                    "id": "TRJ-002", 
                                    "name": "Research Architecture",
                                    "description": "Build upon cross-domain research with structural integrity.",
                                    "editable_fields": ["description", "time_horizon"],
                                    "estimated_efficiency": 0.88
                                }
                            ]
                        },
                        "toroidal_field": {
                            "field_metrics": {
                                "field_stability": 0.9,
                                "color_balance": 0.7
                            }
                        },
                        "purified_output_000": f"## 000 Purified Output\n\nInput processed through Orion v5.0 pipeline. Key insight: Focus on integration."
                    }
                
                def get_current_metrics(self):
                    return {
                        "total_processings": self.session_counter,
                        "average_efficiency": 0.85,
                        "system_health": "OPERATIONAL"
                    }
            
            return MinimalOrionEngineV5(), "Using minimal engine (full v5.0 not available)"
    
    except Exception as e:
        error_msg = f"Engine initialization failed: {str(e)[:200]}"
        st.error(f"❌ {error_msg}")
        return None, error_msg

# Initialize engine
if st.session_state.engine_v5 is None:
    engine, error = initialize_engine_v5()
    st.session_state.engine_v5 = engine
    st.session_state.engine_error = error
    st.session_state.engine_initialized = engine is not None

# ==================== HELPER FUNCTIONS ====================
def get_field_colorscale(balance: float):
    """Get colorscale based on entropy/efficiency balance"""
    if balance > 0.5:
        return [[0, '#0064ff'], [0.5, '#00c8ff'], [1, '#c8ffff']]
    elif balance > 0:
        return [[0, '#0096c8'], [0.5, '#64c896'], [1, '#c8ff96']]
    elif balance > -0.5:
        return [[0, '#c89664'], [0.5, '#dc7850'], [1, '#f05a3c']]
    else:
        return [[0, '#963232'], [0.5, '#b41e1e'], [1, '#dc0a0a']]

def create_toroidal_visualization(field_data: Dict):
    """Create Plotly visualization of toroidal field"""
    
    if not field_data or "x" not in field_data:
        # Create default field
        detail = 50
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        R = TOROIDAL_BASE_RADIUS
        r = 0.5
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        field_data = {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "colorscale": get_field_colorscale(0.7),
            "opacity": 0.7
        }
    
    # Create main surface
    fig = go.Figure(data=[
        go.Surface(
            x=field_data.get("x", []),
            y=field_data.get("y", []),
            z=field_data.get("z", []),
            colorscale=field_data.get("colorscale", "Viridis"),
            opacity=field_data.get("opacity", 0.7),
            showscale=True,
            colorbar=dict(
                title=dict(text="Entropy ↔ Efficiency", side="right"),
                tickvals=[0, 0.5, 1],
                ticktext=["High Entropy", "Balanced", "High Efficiency"]
            ),
            contours={
                "x": {"show": True, "color": "white", "width": 1},
                "y": {"show": True, "color": "white", "width": 1},
                "z": {"show": True, "color": "white", "width": 1}
            }
        )
    ])
    
    # Add field lines if available
    if "field_lines" in field_data:
        lines = field_data["field_lines"]
        fig.add_trace(
            go.Scatter3d(
                x=lines["x"][0] if lines["x"] else [],
                y=lines["y"][0] if lines["y"] else [],
                z=lines["z"][0] if lines["z"] else [],
                mode="lines",
                line=dict(
                    color="rgba(255, 255, 255, 0.5)",
                    width=2
                ),
                showlegend=False
            )
        )
    
    # Update layout
    fig.update_layout(
        title=dict(
            text="🌀 Toroidal Energy Field v5.0",
            font=dict(size=20, color="#8A2BE2")
        ),
        scene=dict(
            xaxis=dict(
                title="Epigenetic Axis",
                gridcolor="rgba(255,255,255,0.1)",
                showbackground=True,
                backgroundcolor="rgba(0,0,0,0)"
            ),
            yaxis=dict(
                title="Neurological Axis",
                gridcolor="rgba(255,255,255,0.1)",
                showbackground=True,
                backgroundcolor="rgba(0,0,0,0)"
            ),
            zaxis=dict(
                title="Quantum Axis",
                gridcolor="rgba(255,255,255,0.1)",
                showbackground=True,
                backgroundcolor="rgba(0,0,0,0)"
            ),
            camera=dict(
                eye=dict(x=1.5, y=1.5, z=1.2)
            ),
            aspectmode="data"
        ),
        width=500,
        height=500,
        margin=dict(l=0, r=0, t=40, b=0),
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="rgba(0,0,0,0)",
        font=dict(color="white")
    )
    
    return fig

# ==================== SIDEBAR ====================
with st.sidebar:
    st.markdown("## 🎮 Orion v5.0 Control Deck")
    
    # Engine Status
    if st.session_state.engine_initialized:
        st.markdown("""
        <div class="engine-status engine-online">
        ⚡ ORION ENGINE v5.0 ONLINE
        </div>
        """, unsafe_allow_html=True)
    else:
        st.markdown(f"""
        <div class="engine-status engine-offline">
        ⚠️ ENGINE OFFLINE
        <br><small>{st.session_state.get('engine_error', 'Unknown error')[:80]}</small>
        </div>
        """, unsafe_allow_html=True)
    
    # User Session
    st.markdown("### 👤 Driver Session")
    st.caption(f"ID: `{st.session_state.user_id}`")
    
    if st.button("🔄 Initialize New Session", use_container_width=True, key="init_session"):
        st.session_state.current_session = {
            "id": f"session_{datetime.now().strftime('%H%M%S')}",
            "start_time": datetime.now().isoformat(),
            "process_count": 0
        }
        st.session_state.processing_history = []
        st.session_state.selected_trajectory = None
        st.rerun()
    
    # Current Session Info
    if st.session_state.current_session:
        st.success(f"✅ Session Active")
        st.caption(f"Started: {st.session_state.current_session.get('start_time', '')[:16]}")
        st.caption(f"Processings: {len(st.session_state.processing_history)}")
    else:
        st.info("No active session. Click 'Initialize New Session' to begin.")
    
    # System Metrics
    st.markdown("### 📊 System Metrics")
    
    if st.session_state.engine_v5:
        try:
            metrics = st.session_state.engine_v5.get_current_metrics()
            col1, col2 = st.columns(2)
            with col1:
                st.metric("Total Processings", metrics.get("total_processings", 0))
                eff = metrics.get("average_efficiency", 0) * 100
                st.metric("Avg Efficiency", f"{eff:.1f}%")
            with col2:
                st.metric("System Health", metrics.get("system_health", "UNKNOWN"))
                if "uptime_human" in metrics:
                    st.caption(f"Uptime: {metrics['uptime_human']}")
        except:
            st.metric("Processings", len(st.session_state.processing_history))
    
    # Field Controls
    st.markdown("### 🌀 Field Controls")
    field_rotation = st.slider("Rotation", 0, 10, 3, key="field_rot")
    field_detail = st.slider("Detail", 30, 100, 50, key="field_detail")
    
    # Pipeline Toggles
    st.markdown("### ⚙️ Pipeline Settings")
    gr_enabled = st.toggle("Ghost Rider Protocol", True, key="gr_toggle")
    wm_enabled = st.toggle("Watermelon Equation", True, key="wm_toggle")
    council_enabled = st.toggle("Council 5.0", True, key="council_toggle")
    
    # Quick Actions
    st.markdown("### ⚡ Quick Actions")
    if st.button("📈 Update All Metrics", use_container_width=True):
        st.rerun()
    
    if st.button("🧹 Clear History", use_container_width=True):
        st.session_state.processing_history = []
        st.session_state.selected_trajectory = None
        st.session_state.edited_trajectories = {}
        st.rerun()

# ==================== MAIN DASHBOARD ====================
st.markdown('<div class="main-header">🌀 ORION CHRONICLES v5.0</div>', unsafe_allow_html=True)

# Pipeline Status Bar
if st.session_state.current_session:
    status_cols = st.columns(5)
    with status_cols[0]:
        st.markdown("**1. Ghost Rider**<br>🛡️ Ready", unsafe_allow_html=True)
    with status_cols[1]:
        st.markdown("**2. Watermelon Eq**<br>🍉 Active", unsafe_allow_html=True)
    with status_cols[2]:
        st.markdown("**3. Council 5.0**<br>🏛️ Assembled", unsafe_allow_html=True)
    with status_cols[3]:
        st.markdown("**4. Matrix Filter**<br>🔀 Operational", unsafe_allow_html=True)
    with status_cols[4]:
        st.markdown("**5. 000 Output**<br>💎 Awaiting", unsafe_allow_html=True)

# Two Column Layout
col_left, col_right = st.columns([2, 1])

with col_left:
    # ==================== SPAGHETTI BRAIN DUMP INPUT ====================
    st.markdown("### 🍝 Spaghetti Brain Dump")
    
    spaghetti_input = st.text_area(
        "Channel your raw thoughts, chaos, questions, or creative sparks:",
        height=250,
        placeholder="""Type anything here... The non-negotiable v5.0 pipeline will process it through:

1. 🛡️ GHOST RIDER: Scan & alchemically transform destructive patterns
2. 🍉 WATERMELON EQ: Apply 1+4+4=9 logic, transmute Rind→Fruit  
3. 🏛️ COUNCIL 5.0: Five specialized agents debate simultaneously
4. 🔀 MATRIX FILTER: Generate editable Alternative Trajectories
5. 💎 000 OUTPUT: Deliver purified, actionable wisdom

Every number is reduced to its digital root. Every word carries weight.
Maximum 10,000 characters.""",
        key="spaghetti_input_v5",
        max_chars=10000,
        help="Your raw input fuels the entire Orion Chronicles v5.0 system"
    )
    
    # Process Button
    process_disabled = not spaghetti_input or not st.session_state.current_session or not st.session_state.engine_v5
    
    if st.button("🚀 LAUNCH v5.0 PROCESSING PIPELINE", 
                 type="primary",
                 use_container_width=True,
                 disabled=process_disabled,
                 key="process_v5"):
        
        if spaghetti_input and st.session_state.current_session and st.session_state.engine_v5:
            with st.spinner("""
            🌀 Orion Chronicles v5.0 Processing Pipeline Activated...
            
            1. Ghost Rider Protocol: Scanning for destructive patterns...
            2. Watermelon Equation: Applying 1+4+4=9 transmutation...
            3. Council 5.0: Convening all five seats...
            4. Matrix Filter: Generating alternative trajectories...
            5. Toroidal Field: Calculating entropy/efficiency balance...
            
            Stand by for 000 Purified Output...
            """):
                
                async def process_pipeline():
                    try:
                        result = await st.session_state.engine_v5.process_spaghetti_dump(spaghetti_input)
                        st.session_state.processing_history.append(result)
                        return result
                    except Exception as e:
                        st.error(f"Pipeline failed: {str(e)[:200]}")
                        return None
                
                result = asyncio.run(process_pipeline())
                
                if result:
                    st.success("""
                    ✅ v5.0 PROCESSING COMPLETE!
                    
                    All five non-negotiable layers processed successfully.
                    000 Purified Output generated with editable Alternative Trajectories.
                    """)
                    st.balloons()
                    st.rerun()
        else:
            if not st.session_state.current_session:
                st.warning("Please initialize a session first!")
            elif not st.session_state.engine_v5:
                st.error("Orion Engine v5.0 is not available!")
    
    # ==================== PROCESSING RESULTS ====================
    if st.session_state.processing_history:
        latest_result = st.session_state.processing_history[-1]
        
        st.markdown("## 📊 Processing Results")
        
        # Create tabs for different views
        tab1, tab2, tab3, tab4 = st.tabs(["🧬 Pipeline Analysis", "🏛️ Council 5.0", "🗺️ Trajectories", "💎 000 Output"])
        
        with tab1:
            # Pipeline Analysis
            st.markdown("### 🧬 v5.0 Pipeline Analysis")
            
            # Phase 1: Ghost Rider
            with st.expander("🛡️ Ghost Rider Protocol", expanded=True):
                gr_report = latest_result.get("ghost_rider_report", {})
                if gr_report.get("activated"):
                    st.warning("**Ghost Rider Protocol ACTIVATED**")
                    st.caption(f"Severity Score: {gr_report.get('severity_score', 0):.2%}")
                    if gr_report.get("transformations"):
                        st.write("**Transformations Applied:**")
                        for t in gr_report["transformations"][:3]:
                            st.write(f"• `{t.get('pattern', '')}` → `{t.get('transformation', '')}`")
                else:
                    st.success("**Ghost Rider Protocol: STANDBY**")
                    st.caption("No destructive patterns detected")
            
            # Phase 2: Watermelon Equation
            with st.expander("🍉 Watermelon Equation", expanded=True):
                wm_analysis = latest_result.get("watermelon_analysis", {})
                transmutation = latest_result.get("transmutation_report", {})
                
                col1, col2 = st.columns(2)
                with col1:
                    st.metric("144 Alignment", 
                             "✅" if wm_analysis.get("is_144_aligned") else "➖",
                             f"{wm_analysis.get('watermelon_frequency', 0):.1f}%")
                with col2:
                    st.metric("Transmutation Eff", 
                             f"{transmutation.get('transmutation_efficiency', 0):.2%}",
                             f"{len(transmutation.get('rind_transformations', []))} transformations")
                
                if wm_analysis.get("numbers_found"):
                    st.caption(f"Numbers found: {', '.join(map(str, wm_analysis['numbers_found'][:5]))}")
                    if len(wm_analysis['numbers_found']) > 5:
                        st.caption(f"... and {len(wm_analysis['numbers_found']) - 5} more")
            
            # Council Metrics
            with st.expander("📈 Council Metrics", expanded=True):
                council_metrics = latest_result.get("council_report", {}).get("council_metrics", {})
                
                col1, col2, col3 = st.columns(3)
                with col1:
                    st.metric("Avg Confidence", f"{council_metrics.get('average_confidence', 0):.1%}")
                with col2:
                    st.metric("Seat Alignment", f"{council_metrics.get('seat_alignment', 0):.1%}")
                with col3:
                    st.metric("Matrix Integrity", f"{council_metrics.get('matrix_integrity', 0):.1%}")
        
        with tab2:
            # Council 5.0 Details
            st.markdown("### 🏛️ Council 5.0 Assembly")
            
            council_report = latest_result.get("council_report", {})
            responses = council_report.get("individual_responses", {})
            
            # Display all five seats
            seats = [
                "Spirit Pulse", "Research Scout", "Ethical Anchor", 
                "The Architect", "Heavy Hauler"
            ]
            
            for seat in seats:
                if seat in responses:
                    response = responses[seat]
                    with st.expander(f"**{seat}** (Confidence: {response.get('confidence', 0):.1%})", 
                                   expanded=seat == "Spirit Pulse"):
                        st.write(response.get("response", "No response"))
                        
                        # Show metrics if available
                        if "metrics" in response:
                            metrics = response["metrics"]
                            cols = st.columns(len(metrics))
                            for col, (key, value) in zip(cols, metrics.items()):
                                with col:
                                    if isinstance(value, (int, float)):
                                        st.metric(key.replace("_", " ").title(), 
                                                 f"{value:.2f}" if value < 1 else f"{value:.0f}")
                                    elif isinstance(value, bool):
                                        st.metric(key.replace("_", " ").title(), 
                                                 "✓" if value else "✗")
            
            # Consensus
            st.markdown("### 🎯 Council Consensus")
            consensus = council_report.get("consensus_report", {})
            st.info(consensus.get("primary_consensus", "No consensus reached"))
            st.caption(f"Confidence: {consensus.get('confidence_score', 0):.1%}")
        
        with tab3:
            # Alternative Trajectories
            st.markdown("### 🗺️ Alternative Trajectories")
            st.caption("""
            **Edit any trajectory below** - these are your customizable paths forward.
            Each trajectory focuses on different aspects of the Council's analysis.
            """)
            
            trajectories = council_report.get("alternative_trajectories", [])
            
            for i, trajectory in enumerate(trajectories):
                with st.container():
                    # Check if this trajectory has been edited
                    traj_id = trajectory.get("id", f"TRJ-{i+1:03d}")
                    edited_key = f"edited_{traj_id}"
                    
                    if edited_key in st.session_state.edited_trajectories:
                        # Use edited version
                        display_traj = st.session_state.edited_trajectories[edited_key]
                    else:
                        # Use original
                        display_traj = trajectory
                    
                    st.markdown(f"""
                    <div class="trajectory-card">
                    <h4>🚀 {display_traj.get('name', f'Trajectory {i+1}')}</h4>
                    <p>{display_traj.get('description', 'No description')}</p>
                    <small><strong>Efficiency:</strong> {display_traj.get('estimated_efficiency', 0):.1%} | 
                    <strong>Risk:</strong> {display_traj.get('risk_factor', 0):.1%} | 
                    <strong>Horizon:</strong> {display_traj.get('time_horizon', 'Variable')}</small>
                    </div>
                    """, unsafe_allow_html=True)
                    
                    # Edit Interface
                    with st.expander(f"✏️ Edit {display_traj.get('name')}", expanded=False):
                        # Name
                        new_name = st.text_input("Trajectory Name", 
                                                value=display_traj.get('name', ''),
                                                key=f"name_{traj_id}")
                        
                        # Description (editable text area)
                        new_desc = st.text_area("Description",
                                               value=display_traj.get('description', ''),
                                               height=100,
                                               key=f"desc_{traj_id}")
                        
                        # Focus areas (editable)
                        focus_areas = display_traj.get('focus_areas', [])
                        new_focus = st.text_input("Focus Areas (comma-separated)",
                                                 value=", ".join(focus_areas) if focus_areas else "",
                                                 key=f"focus_{traj_id}")
                        
                        # Efficiency slider
                        new_efficiency = st.slider("Estimated Efficiency",
                                                  min_value=0.0,
                                                  max_value=1.0,
                                                  value=float(display_traj.get('estimated_efficiency', 0.5)),
                                                  step=0.05,
                                                  key=f"eff_{traj_id}")
                        
                        # Save button
                        if st.button("💾 Save Changes", key=f"save_{traj_id}"):
                            updated_traj = {
                                **display_traj,
                                "name": new_name,
                                "description": new_desc,
                                "focus_areas": [f.strip() for f in new_focus.split(",") if f.strip()],
                                "estimated_efficiency": new_efficiency,
                                "is_edited": True,
                                "edited_by": st.session_state.user_id,
                                "edit_timestamp": datetime.now().isoformat()
                            }
                            
                            st.session_state.edited_trajectories[edited_key] = updated_traj
                            st.success(f"✅ {new_name} updated!")
                            st.rerun()
                        
                        # Select button
                        if st.button("🎯 Select This Trajectory", key=f"select_{traj_id}"):
                            st.session_state.selected_trajectory = updated_traj if 'updated_traj' in locals() else display_traj
                            st.success(f"✅ {st.session_state.selected_trajectory.get('name')} selected!")
        
        with tab4:
            # 000 Purified Output
            st.markdown("### 💎 000 Purified Output")
            purified = latest_result.get("purified_output_000", "No output generated")
            st.markdown(purified)
            
            # Download button
            st.download_button(
                label="📥 Download 000 Output",
                data=purified,
                file_name=f"orion_000_output_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md",
                mime="text/markdown"
            )
            
            # Selected Trajectory Summary
            if st.session_state.selected_trajectory:
                st.markdown("### 🎯 Selected Trajectory")
                selected = st.session_state.selected_trajectory
                st.success(f"**{selected.get('name')}**")
                st.write(selected.get('description', ''))
                st.caption(f"Efficiency: {selected.get('estimated_efficiency', 0):.1%} | "
                          f"Risk: {selected.get('risk_factor', 0):.1%}")

with col_right:
    # ==================== TOROIDAL FIELD VISUALIZATION ====================
    st.markdown("### 🌀 Toroidal Energy Field")
    
    # Get field data from latest result or create default
    field_data = None
    field_metrics = None
    
    if st.session_state.processing_history:
        latest = st.session_state.processing_history[-1]
        field_data = latest.get("toroidal_field")
        field_metrics = latest.get("field_metrics", {})
    else:
        # Default field
        field_metrics = {
            "field_stability": 0.85,
            "color_balance": 0.7,
            "major_radius": TOROIDAL_BASE_RADIUS,
            "minor_radius": 0.5
        }
    
    # Create visualization
    fig = create_toroidal_visualization(field_data)
    
    # Add rotation
    fig.update_layout(
        scene=dict(
            camera=dict(
                eye=dict(
                    x=1.5 * np.cos(field_rotation * 0.2),
                    y=1.5 * np.sin(field_rotation * 0.2),
                    z=1.2
                )
            )
        )
    )
    
    st.plotly_chart(fig, use_container_width=True)
    
    # Field Metrics
    if field_metrics:
        st.markdown("#### 📐 Field Metrics")
        
        col1, col2 = st.columns(2)
        with col1:
            st.metric("Field Stability", f"{field_metrics.get('field_stability', 0):.1%}")
            st.metric("Major Radius", f"{field_metrics.get('major_radius', 0):.2f}")
        with col2:
            balance = field_metrics.get('color_balance', 0)
            balance_label = "High Efficiency" if balance > 0.5 else "Balanced" if balance > 0 else "High Entropy"
            st.metric("Entropy/Efficiency", balance_label)
            st.metric("Minor Radius", f"{field_metrics.get('minor_radius', 0):.2f}")
    
    # ==================== COUNCIL SEAT STATUS ====================
    st.markdown("### 🏛️ Council Seat Status")
    
    seats_status = [
        {"seat": "Spirit Pulse", "status": "Active", "icon": "🌀", "color": "#9C27B0"},
        {"seat": "Research Scout", "status": "Scanning", "icon": "🔬", "color": "#2196F3"},
        {"seat": "Ethical Anchor", "status": "Monitoring", "icon": "⚖️", "color": "#4CAF50"},
        {"seat": "The Architect", "status": "Designing", "icon": "🏗️", "color": "#FF9800"},
        {"seat": "Heavy Hauler", "status": "Ready", "icon": "💥", "color": "#F44336"}
    ]
    
    for seat in seats_status:
        st.markdown(f"""
        <div class="seat-card">
        <div style="display: flex; align-items: center;">
            <span style="font-size: 1.5rem; margin-right: 10px;">{seat['icon']}</span>
            <div>
                <strong>{seat['seat']}</strong><br>
                <small style="color: {seat['color']};">{seat['status']}</small>
            </div>
        </div>
        </div>
        """, unsafe_allow_html=True)
    
    # ==================== WATERMELON EQUATION STATUS ====================
    st.markdown("### 🍉 Watermelon Equation")
    
    if st.session_state.processing_history:
        latest = st.session_state.processing_history[-1]
        wm_analysis = latest.get("watermelon_analysis", {})
        
        if wm_analysis.get("is_144_aligned"):
            st.success("✅ 144 Frequency ALIGNED")
            st.caption(f"Watermelon Frequency: {wm_analysis.get('watermelon_frequency', 0):.1f}%")
        else:
            st.info("➖ 144 Frequency: Neutral")
        
        # Show digital roots if available
        if wm_analysis.get("digital_roots"):
            roots = wm_analysis["digital_roots"]
            unique_roots = set(roots)
            root_text = " ".join([f"**{r}**" for r in sorted(unique_roots)])
            st.caption(f"Digital Roots Found: {root_text}")
    
    # ==================== QUICK STATS ====================
    st.markdown("### 📊 Quick Stats")
    
    col1, col2 = st.columns(2)
    with col1:
        st.metric("Total Processings", len(st.session_state.processing_history))
        if st.session_state.processing_history:
            latest = st.session_state.processing_history[-1]
            gr_activated = latest.get("ghost_rider_report", {}).get("activated", False)
            st.metric("Ghost Rider", "ACTIVE" if gr_activated else "STANDBY")
    
    with col2:
        if st.session_state.processing_history:
            latest = st.session_state.processing_history[-1]
            efficiency = latest.get("transmutation_report", {}).get("transmutation_efficiency", 0)
            st.metric("Efficiency", f"{efficiency:.1%}")
        st.metric("v5.0 Pipeline", "OPERATIONAL")

# ==================== FOOTER ====================
st.markdown("---")
footer_cols = st.columns(4)
with footer_cols[0]:
    st.caption(f"👤 Driver: {st.session_state.user_id}")
with footer_cols[1]:
    st.caption(f"🕐 {datetime.now().strftime('%H:%M:%S UTC')}")
with footer_cols[2]:
    status = "🟢 ACTIVE" if st.session_state.current_session else "🟠 STANDBY"
    st.caption(f"Session: {status}")
with footer_cols[3]:
    st.caption("🌀 Orion Chronicles v5.0")

# ==================== ASYNC SUPPORT ====================
def start_async_loop():
    """Start async event loop in background thread"""
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_forever()

# Start async thread if needed
if st.session_state.async_thread is None:
    try:
        thread = threading.Thread(target=start_async_loop, daemon=True)
        thread.start()
        st.session_state.async_thread = thread
    except:
        pass

# ==================== INITIALIZATION ====================
if not st.session_state.get("v5_initialized", False):
    st.session_state.v5_initialized = True
    st.toast("🌀 Orion Chronicles v5.0 Initialized!", icon="⚡")

if __name__ == "__main__":
    pass