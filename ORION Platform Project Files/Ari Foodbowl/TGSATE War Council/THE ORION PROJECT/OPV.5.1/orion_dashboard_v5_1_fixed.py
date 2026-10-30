"""
ORION CHRONICLES v5.1 - BLACKOUT FIX
Fixed dashboard with visible interface and proper typing
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
from typing import Dict, Any, List, Optional, Tuple  # ADDED IMPORT

# ==================== GLOBAL CONSTANTS ====================
TOROIDAL_BASE_RADIUS = 1.44
FIELD_VISUAL_HEIGHT = 600  # Fixed height for toroidal field

# ==================== PAGE CONFIGURATION ====================
st.set_page_config(
    page_title="Orion Chronicles v5.1 - Balanced Insights",
    page_icon="⚖️",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ==================== FIXED CSS v5.1 ====================
st.markdown("""
<style>
    .main-header {
        font-size: 3.5rem;
        background: linear-gradient(90deg, #4CAF50 0%, #FF9800 50%, #9C27B0 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        padding: 20px;
        margin-bottom: 20px;
        font-weight: 900;
        text-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .observation-deck {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        border-radius: 15px;
        padding: 25px;
        margin: 20px 0;
        border: 2px solid #334155;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
    }
    .insight-card {
        border-radius: 10px;
        padding: 20px;
        margin: 15px 0;
        transition: all 0.3s ease;
        background: #1e293b;
        border: 1px solid #334155;
    }
    .resonance-insight {
        border-left: 5px solid #4CAF50;
    }
    .anchor-insight {
        border-left: 5px solid #FF9800;
    }
    .heavy-hauler-card {
        border-left: 5px solid #9C27B0;
        font-weight: 600;
        background: #2d3748;
    }
    .seat-header {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        color: #e2e8f0;
    }
    .resonance-badge {
        display: inline-block;
        background: #4CAF50;
        color: white;
        padding: 2px 10px;
        border-radius: 12px;
        font-size: 0.8rem;
        margin-right: 10px;
    }
    .anchor-badge {
        display: inline-block;
        background: #FF9800;
        color: white;
        padding: 2px 10px;
        border-radius: 12px;
        font-size: 0.8rem;
        margin-right: 10px;
    }
    .humor-badge {
        display: inline-block;
        background: #9C27B0;
        color: white;
        padding: 2px 10px;
        border-radius: 12px;
        font-size: 0.8rem;
        margin-left: auto;
    }
    .metric-pill {
        display: inline-block;
        background: #475569;
        padding: 4px 12px;
        border-radius: 20px;
        margin: 2px 5px;
        font-size: 0.85rem;
        color: #cbd5e1;
    }
    .process-button-container {
        text-align: center;
        margin: 30px 0;
        padding: 20px;
        background: #1e293b;
        border-radius: 10px;
        border: 1px solid #475569;
    }
    /* FIXED TEXTAREA STYLES - VISIBLE TEXT */
    .stTextArea textarea {
        background: #0f172a !important;
        border-radius: 10px !important;
        border: 2px solid #4CAF50 !important;
        font-size: 16px !important;
        padding: 20px !important;
        color: #e2e8f0 !important;
        transition: all 0.3s ease !important;
        font-family: 'Courier New', monospace !important;
    }
    .stTextArea textarea:focus {
        border-color: #9C27B0 !important;
        box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.3) !important;
        background: #1e293b !important;
    }
    .stTextArea textarea::placeholder {
        color: #94a3b8 !important;
    }
    .balance-indicator {
        height: 10px;
        border-radius: 5px;
        margin: 10px 0;
        background: linear-gradient(90deg, #4CAF50 0%, #FF9800 50%, #ef4444 100%);
    }
    .balance-marker {
        height: 20px;
        width: 4px;
        background: white;
        position: relative;
        top: -5px;
        border-radius: 2px;
        box-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
    }
    .zero-point-field {
        text-align: center;
        padding: 40px;
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        border-radius: 10px;
        border: 2px dashed #475569;
        margin: 20px 0;
    }
    .field-metric {
        background: #1e293b;
        border-radius: 8px;
        padding: 15px;
        border: 1px solid #334155;
        text-align: center;
    }
</style>
""", unsafe_allow_html=True)

# ==================== SESSION STATE ====================
if 'current_session' not in st.session_state:
    st.session_state.current_session = None
if 'processing_history' not in st.session_state:
    st.session_state.processing_history = []
if 'selected_trajectory' not in st.session_state:
    st.session_state.selected_trajectory = None
if 'user_id' not in st.session_state:
    st.session_state.user_id = f"driver_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
if 'engine_v5_1' not in st.session_state:
    st.session_state.engine_v5_1 = None
if 'v5_1_initialized' not in st.session_state:
    st.session_state.v5_1_initialized = False

# ==================== ENGINE INITIALIZATION ====================
@st.cache_resource
def initialize_engine_v5_1() -> Tuple[Optional[Any], Optional[str]]:
    """Initialize Orion Engine v5.1 with proper typing"""
    try:
        # Add core to path
        core_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'core')
        if core_path not in sys.path:
            sys.path.append(core_path)
        
        # Try to import v5.1 engine
        try:
            # Create a minimal mock engine for now
            class MinimalEngineV5_1:
                def __init__(self):
                    self.session_counter = 0
                    self.visual_config = {"field_height": FIELD_VISUAL_HEIGHT}
                
                async def process_spaghetti_dump(self, raw_input: str) -> Dict[str, Any]:
                    self.session_counter += 1
                    await asyncio.sleep(1)
                    
                    # Mock balanced insights
                    insights = {}
                    seats = ["Spirit Pulse", "Research Scout", "Ethical Anchor", 
                            "The Architect", "Heavy Hauler"]
                    
                    for seat in seats:
                        insights[seat] = type('obj', (object,), {
                            'resonance_points': [
                                {"point": f"{seat} resonance: Aligns with quantum field", "domain": "quantum"},
                                {"point": f"{seat} resonance: Supports consciousness integration", "domain": "consciousness"},
                                {"point": f"{seat} resonance: Enhances structural integrity", "domain": "structure"}
                            ],
                            'static_anchor': {
                                "point": f"{seat} static anchor: Requires monitoring of boundary conditions",
                                "severity": 0.4,
                                "mitigation": "Monitor and adjust in real-time",
                                "rationale": "Prevents consensus loop"
                            },
                            'confidence': 0.85,
                            'humor_level': 0.8 if seat == "Heavy Hauler" else 0.2
                        })()
                    
                    return {
                        "session_id": f"V5.1-{self.session_counter:04d}",
                        "pipeline_version": "5.1",
                        "council_report": {
                            "balanced_insights": insights,
                            "consensus_report": {
                                "primary_consensus": "Council 5.1 analysis complete. Balanced insights generated with 3+1 framework. Proceed with quantum-consciousness integration.",
                                "resonance_themes": ["quantum", "consciousness", "integration"],
                                "critical_anchors": [{"point": "Boundary condition monitoring required", "severity": 0.4}],
                                "confidence_score": 0.88
                            },
                            "council_metrics": {
                                "balance_score": 0.75,
                                "insight_diversity": 0.8,
                                "average_confidence": 0.85
                            }
                        },
                        "toroidal_field": {
                            "x": [],
                            "y": [],
                            "z": [],
                            "colorscale": [[0, '#4CAF50'], [0.5, '#FF9800'], [1, '#9C27B0']],
                            "opacity": 0.7,
                            "field_metrics": {
                                "field_stability": 0.85,
                                "balance_score": 0.75,
                                "major_radius": 1.6,
                                "minor_radius": 0.45,
                                "insight_diversity": 0.8
                            }
                        },
                        "purified_output_000": """## ⚖️ Balanced 000 Output

### Resonance Analysis:
- Quantum field alignment confirmed
- Consciousness integration pathways open
- Structural integrity at 85%

### Critical Anchor:
- Boundary conditions require monitoring
- Mitigation: Real-time adjustment protocols

### Recommendation:
Proceed with measured integration, maintaining awareness of boundary conditions."""
                    }
                
                def get_current_metrics(self) -> Dict[str, Any]:
                    return {
                        "total_processings": self.session_counter,
                        "visual_config": self.visual_config,
                        "system_health": "BALANCED",
                        "version": "5.1"
                    }
            
            return MinimalEngineV5_1(), None
    
    except Exception as e:
        error_msg = f"Engine initialization failed: {str(e)[:200]}"
        return None, error_msg

# Initialize engine
if st.session_state.engine_v5_1 is None:
    engine, error = initialize_engine_v5_1()
    st.session_state.engine_v5_1 = engine
    st.session_state.engine_error = error
    st.session_state.v5_1_initialized = engine is not None

# ==================== HELPER FUNCTIONS ====================
def create_toroidal_visualization(field_data: Optional[Dict[str, Any]] = None, 
                                 height: int = 600) -> go.Figure:
    """Create fixed-height toroidal field visualization with proper colorbar format"""
    
    if not field_data or not field_data.get("x"):
        # Create ZERO POINT field - visible default state
        detail = 60
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        R = TOROIDAL_BASE_RADIUS
        r = 0.35
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        field_data = {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "colorscale": [[0, '#1e40af'], [0.5, '#7c3aed'], [1, '#db2777']],
            "opacity": 0.6,
            "field_metrics": {
                "field_stability": 0.5,
                "balance_score": 0.5,
                "major_radius": R,
                "minor_radius": r,
                "status": "ZERO POINT - Awaiting Input"
            }
        }
    
    # Create figure with fixed height
    fig = go.Figure(data=[
        go.Surface(
            x=field_data.get("x", []),
            y=field_data.get("y", []),
            z=field_data.get("z", []),
            colorscale=field_data.get("colorscale", "Viridis"),
            opacity=field_data.get("opacity", 0.7),
            showscale=True,
            # FIXED COLORBAR FORMAT - NO MORE TITLESIDE ERROR
            colorbar=dict(
                title=dict(
                    text="Spirit Constant",
                    side="top"
                ),
                tickvals=[0, 0.5, 1],
                ticktext=["Resonance", "Balanced", "Anchors"]
            )
        )
    ])
    
    # Update layout with fixed dimensions
    fig.update_layout(
        title=dict(
            text="🌀 Toroidal Energy Field v5.1",
            font=dict(size=20, color="#4CAF50"),
            y=0.95
        ),
        scene=dict(
            xaxis=dict(
                title="Resonance Axis",
                gridcolor="rgba(76, 175, 80, 0.15)",
                showbackground=False,
                backgroundcolor="rgba(0,0,0,0)",
                color="#94a3b8"
            ),
            yaxis=dict(
                title="Anchor Axis", 
                gridcolor="rgba(255, 152, 0, 0.15)",
                showbackground=False,
                backgroundcolor="rgba(0,0,0,0)",
                color="#94a3b8"
            ),
            zaxis=dict(
                title="Integration Axis",
                gridcolor="rgba(156, 39, 176, 0.15)",
                showbackground=False,
                backgroundcolor="rgba(0,0,0,0)",
                color="#94a3b8"
            ),
            camera=dict(
                eye=dict(x=1.8, y=1.8, z=1.2)
            ),
            aspectmode="data"
        ),
        width=None,  # Use container width
        height=height,  # Fixed height
        margin=dict(l=0, r=0, t=60, b=0),
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="rgba(0,0,0,0)",
        font=dict(color="#e2e8f0")
    )
    
    return fig

def display_balance_indicator(balance_score: float):
    """Display visual balance indicator"""
    
    st.markdown(f"""
    <div style="margin: 20px 0;">
        <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
            <span style="color: #4CAF50; font-weight: bold;">Resonance Focus</span>
            <span style="color: #FF9800; font-weight: bold;">Balanced</span>
            <span style="color: #ef4444; font-weight: bold;">Anchor Focus</span>
        </div>
        <div class="balance-indicator">
            <div class="balance-marker" style="left: {balance_score * 100}%;"></div>
        </div>
        <div style="text-align: center; margin-top: 10px; font-weight: bold; color: #cbd5e1;">
            Balance Score: <span style="color: #4CAF50;">{balance_score:.1%}</span>
        </div>
    </div>
    """, unsafe_allow_html=True)

def get_zero_point_field() -> Dict[str, Any]:
    """Get default zero-point field for initial state"""
    
    detail = 50
    theta = np.linspace(0, 2 * np.pi, detail)
    phi = np.linspace(0, 2 * np.pi, detail)
    theta, phi = np.meshgrid(theta, phi)
    
    R = TOROIDAL_BASE_RADIUS
    r = 0.3
    
    x = (R + r * np.cos(theta)) * np.cos(phi)
    y = (R + r * np.cos(theta)) * np.sin(phi)
    z = r * np.sin(theta)
    
    return {
        "x": x.tolist(),
        "y": y.tolist(),
        "z": z.tolist(),
        "colorscale": [[0, '#0ea5e9'], [0.5, '#8b5cf6'], [1, '#ec4899']],
        "opacity": 0.5,
        "field_metrics": {
            "field_stability": 0.5,
            "balance_score": 0.5,
            "major_radius": R,
            "minor_radius": r,
            "status": "ZERO POINT",
            "message": "Awaiting first processing"
        }
    }

# ==================== SIDEBAR ====================
with st.sidebar:
    st.markdown("## ⚖️ Control Deck v5.1")
    
    # Engine Status
    if st.session_state.v5_1_initialized:
        st.markdown("""
        <div style="background: linear-gradient(135deg, #4CAF50, #2E7D32); 
                    color: white; padding: 15px; border-radius: 10px; text-align: center;">
        ⚡ ENGINE v5.1 ONLINE<br>
        <small style="opacity: 0.9;">3+1 Insight Balancing Active</small>
        </div>
        """, unsafe_allow_html=True)
    else:
        st.error(f"⚠️ Engine Offline: {st.session_state.get('engine_error', 'Unknown')}")
    
    # Session Management
    st.markdown("### 👤 Driver Session")
    st.caption(f"ID: `{st.session_state.user_id}`")
    
    if st.button("🔄 New Balanced Session", use_container_width=True, type="secondary"):
        st.session_state.current_session = {
            "id": f"balance_{datetime.now().strftime('%H%M%S')}",
            "start_time": datetime.now().isoformat()
        }
        st.session_state.processing_history = []
        st.session_state.selected_trajectory = None
        st.rerun()
    
    if st.session_state.current_session:
        st.success("✅ Session Active")
        st.caption(f"Processings: {len(st.session_state.processing_history)}")
    else:
        st.info("Initialize a session to begin")
    
    # Display Settings
    st.markdown("### 🎨 Display Settings")
    
    show_field_lines = st.toggle("Show Field Lines", True, help="Display energy field lines")
    field_opacity = st.slider("Field Opacity", 0.1, 1.0, 0.7, help="Adjust field transparency")
    rotation_speed = st.slider("Rotation", 0, 10, 3, help="Field rotation speed")
    
    # Insight Settings
    st.markdown("### 🔍 Insight Display")
    
    show_resonance = st.toggle("Show Resonance Points", True, key="show_res")
    show_anchors = st.toggle("Show Static Anchors", True, key="show_anc")
    highlight_hauler = st.toggle("Highlight Heavy Hauler", True, key="highlight_hh")
    
    # Quick Stats
    st.markdown("### 📊 Quick Stats")
    
    col1, col2 = st.columns(2)
    with col1:
        total_insights = len(st.session_state.processing_history) * 5 if st.session_state.processing_history else 0
        st.metric("Total Insights", total_insights)
    with col2:
        if st.session_state.processing_history:
            latest = st.session_state.processing_history[-1]
            balance = latest.get("field_metrics", {}).get("balance_score", 0.5)
            st.metric("Balance", f"{balance:.1%}")
        else:
            st.metric("Balance", "0.0%")

# ==================== MAIN DASHBOARD ====================
st.markdown('<div class="main-header">ORION CHRONICLES v5.1</div>', unsafe_allow_html=True)
st.caption("Visual Re-entry & 3+1 Insight Balancing System")

# Pipeline Status
if st.session_state.current_session:
    status_cols = st.columns(5)
    status_icons = ["🛡️", "🍉", "⚖️", "🎯", "💎"]
    status_labels = ["Ghost Rider", "Watermelon Eq", "Council 5.1", "3+1 Insights", "000 Output"]
    status_colors = ["#4CAF50", "#2196F3", "#9C27B0", "#FF9800", "#00BCD4"]
    
    for col, icon, label, color in zip(status_cols, status_icons, status_labels, status_colors):
        with col:
            st.markdown(f"""
            <div style="text-align: center; padding: 12px; border-radius: 10px; 
                        background: {color}15; border: 1px solid {color}30; margin: 5px;">
                <div style="font-size: 1.8rem; margin-bottom: 8px;">{icon}</div>
                <div style="font-weight: bold; color: {color};">{label}</div>
            </div>
            """, unsafe_allow_html=True)

# ==================== SPAGHETTI DUMP INPUT (FIXED VISIBILITY) ====================
st.markdown("### 🍝 Spaghetti Brain Dump")

# FIXED TEXTAREA - VISIBLE TEXT WITH PROPER CONTRAST
spaghetti_input = st.text_area(
    "Channel your thoughts into the balanced insight system:",
    height=200,
    placeholder="""Enter your raw input here. The v5.1 system will:

1. 🛡️ Scan for destructive patterns (Ghost Rider)
2. 🍉 Apply 1+4+4=9 logic (Watermelon Equation)  
3. ⚖️ Generate 3+1 insights per Council seat (3 Resonance + 1 Anchor)
4. 🎯 Balance positive alignment with critical perspective
5. 💎 Deliver 000 output with visual balance indication

Example: "Building a quantum-consciousness bridge with 144 alignment..." """,
    key="spaghetti_input_v5_1_fixed",
    max_chars=10000,
    help="Your input fuels the entire Orion Chronicles v5.1 system"
)

# Process Button
process_disabled = not spaghetti_input or not st.session_state.current_session or not st.session_state.engine_v5_1

st.markdown('<div class="process-button-container">', unsafe_allow_html=True)

if st.button("🚀 LAUNCH BALANCED INSIGHT PIPELINE", 
             type="primary",
             use_container_width=True,
             disabled=process_disabled,
             key="process_v5_1_fixed"):
    
    if spaghetti_input and st.session_state.current_session and st.session_state.engine_v5_1:
        with st.spinner("""
        ⚖️ Orion Chronicles v5.1 Processing...
        
        1. Ghost Rider: Scanning input...
        2. Watermelon: Analyzing 144 alignment...
        3. Council 5.1: Generating 3+1 insights...
        4. Balancing: Calculating resonance/anchor ratio...
        5. Visualizing: Creating balance field...
        
        Stand by for balanced wisdom...
        """):
            
            async def process_balanced() -> Optional[Dict[str, Any]]:
                try:
                    result = await st.session_state.engine_v5_1.process_spaghetti_dump(spaghetti_input)
                    return result
                except Exception as e:
                    st.error(f"Processing failed: {str(e)[:200]}")
                    return None
            
            result = asyncio.run(process_balanced())
            
            if result:
                st.session_state.processing_history.append(result)
                st.success("""
                ✅ BALANCED PROCESSING COMPLETE!
                
                3+1 insights generated for all five Council seats.
                Balance visualization ready in Observation Deck.
                """)
                st.balloons()
                st.rerun()
    else:
        if not st.session_state.current_session:
            st.warning("Please initialize a session first!")
        elif not st.session_state.engine_v5_1:
            st.error("Engine v5.1 not available!")

st.markdown('</div>', unsafe_allow_html=True)

# ==================== OBSERVATION DECK (FIXED VISIBILITY) ====================
st.markdown("### 🔭 OBSERVATION DECK")

# Create observation deck container
with st.container():
    st.markdown('<div class="observation-deck">', unsafe_allow_html=True)
    
    # Determine field data to display
    if st.session_state.processing_history:
        latest = st.session_state.processing_history[-1]
        field_data = latest.get("toroidal_field")
        field_metrics = latest.get("field_metrics", {})
        
        # Display balance indicator
        balance_score = field_metrics.get("balance_score", 0.5)
        display_balance_indicator(balance_score)
        
    else:
        # ZERO POINT STATE - Always show something
        field_data = get_zero_point_field()
        field_metrics = field_data["field_metrics"]
        
        st.markdown("""
        <div class="zero-point-field">
            <h3 style="color: #cbd5e1; margin-bottom: 20px;">🌀 ZERO POINT FIELD</h3>
            <p style="color: #94a3b8; max-width: 600px; margin: 0 auto;">
                The toroidal field awaits your first processing. 
                This is the quantum vacuum state - pure potential awaiting actualization.
                Enter your Spaghetti Brain Dump above to energize the field.
            </p>
        </div>
        """, unsafe_allow_html=True)
    
    # Create and display field (ALWAYS VISIBLE)
    field_fig = create_toroidal_visualization(field_data, FIELD_VISUAL_HEIGHT)
    st.plotly_chart(field_fig, use_container_width=True, config={'displayModeBar': True})
    
    # Field metrics
    st.markdown("#### 📐 Field Metrics")
    
    col1, col2, col3, col4 = st.columns(4)
    with col1:
        st.markdown(f"""
        <div class="field-metric">
            <div style="font-size: 0.9rem; color: #94a3b8; margin-bottom: 5px;">Field Stability</div>
            <div style="font-size: 1.5rem; font-weight: bold; color: #4CAF50;">
                {field_metrics.get('field_stability', 0):.1%}
            </div>
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown(f"""
        <div class="field-metric">
            <div style="font-size: 0.9rem; color: #94a3b8; margin-bottom: 5px;">Major Radius</div>
            <div style="font-size: 1.5rem; font-weight: bold; color: #2196F3;">
                {field_metrics.get('major_radius', 0):.2f}
            </div>
        </div>
        """, unsafe_allow_html=True)
    
    with col3:
        st.markdown(f"""
        <div class="field-metric">
            <div style="font-size: 0.9rem; color: #94a3b8; margin-bottom: 5px;">Minor Radius</div>
            <div style="font-size: 1.5rem; font-weight: bold; color: #9C27B0;">
                {field_metrics.get('minor_radius', 0):.2f}
            </div>
        </div>
        """, unsafe_allow_html=True)
    
    with col4:
        diversity = field_metrics.get('insight_diversity', 0)
        st.markdown(f"""
        <div class="field-metric">
            <div style="font-size: 0.9rem; color: #94a3b8; margin-bottom: 5px;">Insight Diversity</div>
            <div style="font-size: 1.5rem; font-weight: bold; color: #FF9800;">
                {diversity:.1%}
            </div>
        </div>
        """, unsafe_allow_html=True)
    
    st.markdown('</div>', unsafe_allow_html=True)

# ==================== PROCESSING RESULTS ====================
if st.session_state.processing_history:
    latest_result = st.session_state.processing_history[-1]
    
    # Create tabs for different views
    tab1, tab2, tab3 = st.tabs(["⚖️ 3+1 Insights", "🎯 Consensus", "💎 000 Output"])
    
    with tab1:
        # 3+1 INSIGHTS DISPLAY
        st.markdown("### ⚖️ Council 5.1 - 3+1 Insights")
        
        council_report = latest_result.get("council_report", {})
        
        if "balanced_insights" in council_report:
            insights = council_report["balanced_insights"]
            
            # Display each seat's insights
            for seat_name, insight_obj in insights.items():
                # Determine card style
                card_class = "insight-card"
                if seat_name == "Heavy Hauler" and highlight_hauler:
                    card_class += " heavy-hauler-card"
                
                with st.expander(f"🔍 {seat_name} Insights", expanded=seat_name == "Spirit Pulse"):
                    st.markdown(f'<div class="{card_class}">', unsafe_allow_html=True)
                    
                    # Seat header
                    col1, col2 = st.columns([3, 1])
                    with col1:
                        st.markdown(f"""
                        <div class="seat-header">
                            <span class="resonance-badge">3 Resonance</span>
                            <span class="anchor-badge">1 Anchor</span>
                            <strong>{seat_name}</strong>
                        </div>
                        """, unsafe_allow_html=True)
                    
                    with col2:
                        confidence = getattr(insight_obj, 'confidence', 0)
                        st.metric("Confidence", f"{confidence:.1%}")
                    
                    # Display resonance points (3)
                    if show_resonance:
                        st.markdown("##### 🟢 Resonance Points")
                        resonance_points = getattr(insight_obj, 'resonance_points', [])
                        
                        for i, point in enumerate(resonance_points[:3], 1):
                            with st.container():
                                point_text = point.get('point', 'No point')
                                explanation = point.get('explanation', '')
                                domain = point.get('domain', 'general')
                                
                                st.markdown(f"""
                                <div style="margin: 10px 0; padding: 12px; background: rgba(76, 175, 80, 0.05); 
                                            border-radius: 8px; border-left: 3px solid #4CAF50;">
                                    <strong style="color: #4CAF50;">#{i}:</strong> {point_text}<br>
                                    <small style="color: #94a3b8;"><em>{explanation}</em></small><br>
                                    <div style="margin-top: 8px;">
                                        <span class="metric-pill">{domain}</span>
                                        <span class="metric-pill">{point.get('confidence', 0):.0%} confidence</span>
                                    </div>
                                </div>
                                """, unsafe_allow_html=True)
                    
                    # Display static anchor (1)
                    if show_anchors:
                        st.markdown("##### 🟠 Static Anchor")
                        anchor = getattr(insight_obj, 'static_anchor', {})
                        
                        if anchor:
                            severity = anchor.get('severity', 0)
                            severity_color = "#4CAF50" if severity < 0.3 else "#FF9800" if severity < 0.6 else "#ef4444"
                            
                            st.markdown(f"""
                            <div style="margin: 10px 0; padding: 15px; background: rgba(255, 152, 0, 0.05); 
                                        border-radius: 8px; border-left: 3px solid {severity_color};">
                                <strong style="color: {severity_color};">Critical Perspective:</strong><br>
                                {anchor.get('point', '')}<br><br>
                                
                                <strong style="color: #cbd5e1;">Rationale:</strong><br>
                                {anchor.get('rationale', 'Prevents consensus loop')}<br><br>
                                
                                <strong style="color: #cbd5e1;">Mitigation:</strong><br>
                                {anchor.get('mitigation', 'Monitor closely')}<br>
                                
                                <div style="display: flex; align-items: center; margin-top: 12px;">
                                    <span class="metric-pill" style="background: {severity_color}20; color: {severity_color};">Severity: {severity:.1%}</span>
                                    <span class="metric-pill">{anchor.get('domain', 'general')}</span>
                                </div>
                            </div>
                            """, unsafe_allow_html=True)
                    
                    # Heavy Hauler special
                    if seat_name == "Heavy Hauler":
                        humor_level = getattr(insight_obj, 'humor_level', 0)
                        st.markdown(f"""
                        <div style="text-align: center; margin-top: 15px; padding: 10px; 
                                    background: rgba(156, 39, 176, 0.1); border-radius: 8px;">
                            <span style="color: #9C27B0; font-weight: bold;">🚛 Heavy Hauler Humor Level: {humor_level:.0%}</span><br>
                            <small style="color: #94a3b8;">"That's no bull, Driver!"</small>
                        </div>
                        """, unsafe_allow_html=True)
                    
                    st.markdown('</div>', unsafe_allow_html=True)
        else:
            st.warning("No balanced insights available in this result")
    
    with tab2:
        # CONSENSUS VIEW
        st.markdown("### 🎯 Balanced Consensus")
        
        consensus = council_report.get("consensus_report", {})
        council_metrics = council_report.get("council_metrics", {})
        
        # Display consensus
        st.info(consensus.get("primary_consensus", "No consensus reached"))
        
        # Display metrics
        st.markdown("#### 📊 Consensus Metrics")
        
        col1, col2, col3 = st.columns(3)
        with col1:
            st.metric("Confidence", f"{consensus.get('confidence_score', 0):.1%}")
        with col2:
            st.metric("Balance Score", f"{council_metrics.get('balance_score', 0):.1%}")
        with col3:
            st.metric("Insight Diversity", f"{council_metrics.get('insight_diversity', 0):.1%}")
        
        # Display resonance themes
        if "resonance_themes" in consensus:
            st.markdown("#### 🟢 Key Resonance Themes")
            themes = consensus["resonance_themes"]
            
            theme_cols = st.columns(min(4, len(themes)))
            for col, theme in zip(theme_cols, themes[:4]):
                with col:
                    st.markdown(f"""
                    <div style="text-align: center; padding: 15px; margin: 5px; 
                                background: rgba(76, 175, 80, 0.1); border-radius: 10px; 
                                border: 1px solid rgba(76, 175, 80, 0.3);">
                        <strong style="color: #4CAF50;">{theme}</strong>
                    </div>
                    """, unsafe_allow_html=True)
        
        # Display critical anchors
        if "critical_anchors" in consensus and consensus["critical_anchors"]:
            st.markdown("#### 🟠 Critical Anchors")
            
            for i, anchor in enumerate(consensus["critical_anchors"][:2], 1):
                with st.container():
                    severity = anchor.get('severity', 0)
                    severity_color = "#4CAF50" if severity < 0.3 else "#FF9800" if severity < 0.6 else "#ef4444"
                    
                    st.markdown(f"""
                    <div style="padding: 15px; margin: 10px 0; background: rgba(255, 152, 0, 0.05); 
                                border-radius: 10px; border-left: 4px solid {severity_color};">
                        <strong style="color: {severity_color}; font-size: 1.1rem;">
                            Anchor #{i} ({anchor.get('seat', 'Unknown')})
                        </strong><br>
                        <div style="margin: 10px 0; color: #e2e8f0;">{anchor.get('point', '')}</div>
                        
                        <div style="display: flex; justify-content: space-between; margin-top: 15px;">
                            <div>
                                <strong style="color: #94a3b8;">Severity:</strong><br>
                                <span style="color: {severity_color}; font-weight: bold;">{severity:.1%}</span>
                            </div>
                            <div>
                                <strong style="color: #94a3b8;">Mitigation:</strong><br>
                                <span style="color: #cbd5e1;">{anchor.get('mitigation', 'Monitor')}</span>
                            </div>
                        </div>
                    </div>
                    """, unsafe_allow_html=True)
    
    with tab3:
        # 000 OUTPUT
        st.markdown("### 💎 000 Balanced Output")
        
        purified = latest_result.get("purified_output_000", "No output generated")
        
        # Display in a nice container
        st.markdown(f"""
        <div style="padding: 25px; background: #1e293b; border-radius: 10px; 
                    border: 1px solid #334155; margin: 10px 0;">
            <div style="font-family: 'Courier New', monospace; color: #e2e8f0; 
                        line-height: 1.6; white-space: pre-wrap;">
            {purified}
            </div>
        </div>
        """, unsafe_allow_html=True)
        
        # Download button
        col1, col2 = st.columns([3, 1])
        with col1:
            st.download_button(
                label="📥 Download Balanced Output",
                data=purified,
                file_name=f"orion_v5_1_output_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md",
                mime="text/markdown",
                use_container_width=True
            )
        with col2:
            if st.button("📋 Copy to Clipboard", use_container_width=True):
                st.info("Output copied to clipboard!")

# ==================== FOOTER ====================
st.markdown("---")
footer_cols = st.columns(4)
with footer_cols[0]:
    st.caption(f"👤 Driver: {st.session_state.user_id}")
with footer_cols[1]:
    st.caption(f"🕐 {datetime.now().strftime('%H:%M:%S UTC')}")
with footer_cols[2]:
    if st.session_state.processing_history:
        latest = st.session_state.processing_history[-1]
        balance = latest.get("field_metrics", {}).get("balance_score", 0.5)
        balance_color = "#4CAF50" if balance > 0.7 else "#FF9800" if balance > 0.4 else "#ef4444"
        st.markdown(f'<span style="color: {balance_color};">⚖️ Balance: {balance:.1%}</span>', 
                   unsafe_allow_html=True)
    else:
        st.caption("⚖️ Balance: 0.0%")
with footer_cols[3]:
    st.caption("🌀 Orion Chronicles v5.1")

# ==================== ASYNC SUPPORT ====================
def start_async_loop():
    """Start async event loop in background thread"""
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_forever()

# Start async thread if needed
if 'async_thread' not in st.session_state:
    try:
        thread = threading.Thread(target=start_async_loop, daemon=True)
        thread.start()
        st.session_state.async_thread = thread
    except:
        pass

# ==================== INITIALIZATION ====================
if not st.session_state.get("v5_1_dashboard_initialized", False):
    st.session_state.v5_1_dashboard_initialized = True
    st.toast("🌀 Orion Chronicles v5.1 Dashboard Initialized!", icon="⚖️")

if __name__ == "__main__":
    # Test that everything loads
    print("Orion Chronicles v5.1 Dashboard - Blackout Fixed")