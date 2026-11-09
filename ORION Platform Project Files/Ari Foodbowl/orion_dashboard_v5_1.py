"""
ORION CHRONICLES v5.1 DASHBOARD
Visual Re-entry & Insight Balancing Interface
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
from typing import Dict, List, Any, Optional

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

# ==================== CUSTOM CSS v5.1 ====================
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
        background: linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.9) 100%);
        border-radius: 15px;
        padding: 25px;
        margin: 20px 0;
        border: 2px solid rgba(76, 175, 80, 0.3);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }
    .insight-card {
        border-radius: 10px;
        padding: 20px;
        margin: 15px 0;
        transition: all 0.3s ease;
    }
    .resonance-insight {
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.1) 0%, rgba(76, 175, 80, 0.05) 100%);
        border-left: 5px solid #4CAF50;
        border-right: 2px solid rgba(76, 175, 80, 0.3);
    }
    .anchor-insight {
        background: linear-gradient(135deg, rgba(255, 152, 0, 0.1) 0%, rgba(255, 152, 0, 0.05) 100%);
        border-left: 5px solid #FF9800;
        border-right: 2px solid rgba(255, 152, 0, 0.3);
    }
    .heavy-hauler-card {
        background: linear-gradient(135deg, rgba(156, 39, 176, 0.1) 0%, rgba(156, 39, 176, 0.05) 100%);
        border-left: 5px solid #9C27B0;
        border-right: 2px solid rgba(156, 39, 176, 0.3);
        font-weight: 600;
    }
    .seat-header {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
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
        background: rgba(255, 255, 255, 0.1);
        padding: 4px 12px;
        border-radius: 20px;
        margin: 2px 5px;
        font-size: 0.85rem;
    }
    .process-button-container {
        text-align: center;
        margin: 30px 0;
    }
    .stTextArea textarea {
        background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
        border-radius: 10px;
        border: 2px solid #4CAF50;
        font-size: 16px;
        padding: 20px;
        color: #ffffff;
        transition: all 0.3s ease;
    }
    .stTextArea textarea:focus {
        border-color: #9C27B0;
        box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.2);
    }
    .balance-indicator {
        height: 10px;
        border-radius: 5px;
        margin: 10px 0;
        background: linear-gradient(90deg, #4CAF50 0%, #FF9800 50%, #f44336 100%);
    }
    .balance-marker {
        height: 20px;
        width: 4px;
        background: white;
        position: relative;
        top: -5px;
        border-radius: 2px;
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
def initialize_engine_v5_1():
    """Initialize Orion Engine v5.1"""
    try:
        # Add core to path
        core_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'core')
        if core_path not in sys.path:
            sys.path.append(core_path)
        
        # Try to import v5.1 engine
        try:
            from orion_engine_v5_1 import get_orion_engine_v5_1
            engine = get_orion_engine_v5_1()
            st.success("✅ Orion Engine v5.1 Initialized!")
            return engine, None
        except ImportError:
            # Create minimal fallback
            class MinimalEngineV5_1:
                def __init__(self):
                    self.session_counter = 0
                    self.visual_config = {"field_height": FIELD_VISUAL_HEIGHT}
                
                async def process_spaghetti_dump(self, raw_input: str):
                    self.session_counter += 1
                    await asyncio.sleep(1)
                    
                    # Mock balanced insights
                    insights = {}
                    seats = ["Spirit Pulse", "Research Scout", "Ethical Anchor", 
                            "The Architect", "Heavy Hauler"]
                    
                    for seat in seats:
                        insights[seat] = type('obj', (object,), {
                            'resonance_points': [
                                {"point": f"{seat} resonance point 1", "domain": "general"},
                                {"point": f"{seat} resonance point 2", "domain": "quantum"},
                                {"point": f"{seat} resonance point 3", "domain": "consciousness"}
                            ],
                            'static_anchor': {
                                "point": f"{seat} static anchor: Critical perspective here",
                                "severity": 0.4,
                                "mitigation": "Monitor and adjust"
                            },
                            'confidence': 0.85,
                            'humor_level': 0.8 if seat == "Heavy Hauler" else 0.2
                        })()
                    
                    return {
                        "session_id": f"V5.1-{self.session_counter:04d}",
                        "pipeline_version": "5.1-minimal",
                        "council_report": {
                            "balanced_insights": insights,
                            "consensus_report": {
                                "primary_consensus": "Council 5.1 analysis complete with balanced insights.",
                                "resonance_themes": ["quantum", "consciousness", "integration"],
                                "critical_anchors": [{"point": "Sample critical anchor", "severity": 0.4}]
                            },
                            "council_metrics": {
                                "balance_score": 0.75,
                                "insight_diversity": 0.8
                            }
                        },
                        "toroidal_field": {
                            "field_metrics": {
                                "field_stability": 0.85,
                                "balance_score": 0.75,
                                "major_radius": 1.6,
                                "minor_radius": 0.45
                            }
                        },
                        "purified_output_000": "## Balanced 000 Output\n\nInsights generated with 3+1 framework."
                    }
                
                def get_current_metrics(self):
                    return {
                        "total_processings": self.session_counter,
                        "visual_config": self.visual_config,
                        "system_health": "BALANCED"
                    }
            
            return MinimalEngineV5_1(), "Using minimal v5.1 engine"
    
    except Exception as e:
        return None, f"Engine initialization failed: {str(e)[:200]}"

# Initialize engine
if st.session_state.engine_v5_1 is None:
    engine, error = initialize_engine_v5_1()
    st.session_state.engine_v5_1 = engine
    st.session_state.engine_error = error
    st.session_state.v5_1_initialized = engine is not None

# ==================== HELPER FUNCTIONS ====================
def create_toroidal_visualization(field_data: Dict, height: int = 600):
    """Create fixed-height toroidal field visualization"""
    
    if not field_data:
        # Create default field
        detail = 80
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        R = TOROIDAL_BASE_RADIUS * 1.1
        r = 0.45
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        field_data = {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "colorscale": [[0, '#4CAF50'], [0.5, '#FF9800'], [1, '#9C27B0']],
            "opacity": 0.7
        }
    
    # Create figure with fixed height
    fig = go.Figure(data=[
        go.Surface(
            x=field_data.get("x", []),
            y=field_data.get("y", []),
            z=field_data.get("z", []),
            colorscale=field_data.get("colorscale", "Balance"),
            opacity=field_data.get("opacity", 0.7),
            showscale=True,
            colorbar=dict(
                title="Balance Visualization",
                titleside="right",
                tickvals=[0, 0.5, 1],
                ticktext=["Resonance", "Balanced", "Anchors"]
            )
        )
    ])
    
    # Update layout with fixed dimensions
    fig.update_layout(
        title=dict(
            text="🌀 Toroidal Energy Field v5.1 - Balance Visualization",
            font=dict(size=18, color="#4CAF50"),
            y=0.95
        ),
        scene=dict(
            xaxis=dict(
                title="Resonance Axis",
                gridcolor="rgba(76, 175, 80, 0.1)",
                showbackground=False
            ),
            yaxis=dict(
                title="Anchor Axis", 
                gridcolor="rgba(255, 152, 0, 0.1)",
                showbackground=False
            ),
            zaxis=dict(
                title="Integration Axis",
                gridcolor="rgba(156, 39, 176, 0.1)",
                showbackground=False
            ),
            camera=dict(
                eye=dict(x=1.8, y=1.8, z=1.2)
            ),
            aspectmode="data"
        ),
        width=None,  # Use container width
        height=height,  # Fixed height
        margin=dict(l=0, r=0, t=50, b=0),
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="rgba(0,0,0,0)",
        font=dict(color="#ffffff")
    )
    
    return fig

def display_balance_indicator(balance_score: float):
    """Display visual balance indicator"""
    
    st.markdown(f"""
    <div style="margin: 20px 0;">
        <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
            <span style="color: #4CAF50;">Resonance Focus</span>
            <span style="color: #FF9800;">Balanced</span>
            <span style="color: #f44336;">Anchor Focus</span>
        </div>
        <div class="balance-indicator">
            <div class="balance-marker" style="left: {balance_score * 100}%;"></div>
        </div>
        <div style="text-align: center; margin-top: 5px; font-weight: bold;">
            Balance Score: {balance_score:.1%}
        </div>
    </div>
    """, unsafe_allow_html=True)

# ==================== SIDEBAR ====================
with st.sidebar:
    st.markdown("## ⚖️ Control Deck v5.1")
    
    # Engine Status
    if st.session_state.v5_1_initialized:
        st.markdown("""
        <div style="background: linear-gradient(135deg, #4CAF50, #2E7D32); 
                    color: white; padding: 15px; border-radius: 10px; text-align: center;">
        ⚡ ENGINE v5.1 ONLINE<br>
        <small>3+1 Insight Balancing Active</small>
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
        st.rerun()
    
    if st.session_state.current_session:
        st.success("✅ Session Active")
        st.caption(f"Processings: {len(st.session_state.processing_history)}")
    else:
        st.info("Initialize a session to begin")
    
    # Insight Configuration
    st.markdown("### ⚙️ Insight Settings")
    
    resonance_weight = st.slider("Resonance Weight", 0.0, 1.0, 0.6, 
                                help="How much to weight positive resonance points")
    anchor_weight = st.slider("Anchor Weight", 0.0, 1.0, 0.4,
                             help="How much to weight critical anchors")
    
    st.caption(f"Balance Ratio: {resonance_weight:.1f}:{anchor_weight:.1f}")
    
    # Display Settings
    st.markdown("### 🎨 Display")
    
    show_resonance_details = st.toggle("Show Resonance Details", True)
    show_anchor_details = st.toggle("Show Anchor Details", True)
    highlight_heavy_hauler = st.toggle("Highlight Heavy Hauler", True)
    
    # Quick Stats
    st.markdown("### 📊 Quick Stats")
    
    col1, col2 = st.columns(2)
    with col1:
        st.metric("Total Insights", 
                 len(st.session_state.processing_history) * 5 if st.session_state.processing_history else 0)
    with col2:
        if st.session_state.processing_history:
            latest = st.session_state.processing_history[-1]
            balance = latest.get("field_metrics", {}).get("balance_score", 0.5)
            st.metric("Balance", f"{balance:.1%}")

# ==================== MAIN DASHBOARD ====================
st.markdown('<div class="main-header">ORION CHRONICLES v5.1</div>', unsafe_allow_html=True)
st.caption("Visual Re-entry & 3+1 Insight Balancing System")

# Pipeline Status
if st.session_state.current_session:
    status_cols = st.columns(5)
    status_data = [
        ("1. Ghost Rider", "🛡️", "#4CAF50"),
        ("2. Watermelon Eq", "🍉", "#2196F3"),
        ("3. Council 5.1", "⚖️", "#9C27B0"),
        ("4. 3+1 Insights", "🎯", "#FF9800"),
        ("5. 000 Output", "💎", "#00BCD4")
    ]
    
    for col, (label, icon, color) in zip(status_cols, status_data):
        with col:
            st.markdown(f"""
            <div style="text-align: center; padding: 10px; border-radius: 10px; 
                        background: {color}20; border: 1px solid {color}40;">
                <div style="font-size: 1.5rem;">{icon}</div>
                <div><strong>{label}</strong></div>
            </div>
            """, unsafe_allow_html=True)

# ==================== SPAGHETTI DUMP INPUT ====================
st.markdown("### 🍝 Spaghetti Brain Dump")

spaghetti_input = st.text_area(
    "Channel your thoughts into the balanced insight system:",
    height=200,
    placeholder="""Enter your raw input here. The v5.1 system will:

1. 🛡️ Scan for destructive patterns (Ghost Rider)
2. 🍉 Apply 1+4+4=9 logic (Watermelon Equation)  
3. ⚖️ Generate 3+1 insights per Council seat (3 Resonance + 1 Anchor)
4. 🎯 Balance positive alignment with critical perspective
5. 💎 Deliver 000 output with visual balance indication

Maximum 10,000 characters.""",
    key="spaghetti_input_v5_1",
    max_chars=10000
)

# Process Button
process_disabled = not spaghetti_input or not st.session_state.current_session or not st.session_state.engine_v5_1

st.markdown('<div class="process-button-container">', unsafe_allow_html=True)

if st.button("🚀 LAUNCH BALANCED INSIGHT PIPELINE", 
             type="primary",
             use_container_width=True,
             disabled=process_disabled,
             key="process_v5_1"):
    
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
            
            async def process_balanced():
                try:
                    result = await st.session_state.engine_v5_1.process_spaghetti_dump(spaghetti_input)
                    st.session_state.processing_history.append(result)
                    return result
                except Exception as e:
                    st.error(f"Processing failed: {str(e)[:200]}")
                    return None
            
            result = asyncio.run(process_balanced())
            
            if result:
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

# ==================== OBSERVATION DECK ====================
st.markdown("### 🔭 OBSERVATION DECK")

# Create observation deck container
observation_deck = st.container()

with observation_deck:
    st.markdown('<div class="observation-deck">', unsafe_allow_html=True)
    
    # Toroidal Field Visualization (Full Width, Fixed Height)
    if st.session_state.processing_history:
        latest = st.session_state.processing_history[-1]
        field_data = latest.get("toroidal_field")
        field_metrics = latest.get("field_metrics", {})
        
        # Display balance indicator
        balance_score = field_metrics.get("balance_score", 0.5)
        display_balance_indicator(balance_score)
        
        # Create and display field
        field_fig = create_toroidal_visualization(field_data, FIELD_VISUAL_HEIGHT)
        st.plotly_chart(field_fig, use_container_width=True, config={'displayModeBar': True})
        
        # Field metrics
        col1, col2, col3, col4 = st.columns(4)
        with col1:
            st.metric("Field Stability", f"{field_metrics.get('field_stability', 0):.1%}")
        with col2:
            st.metric("Major Radius", f"{field_metrics.get('major_radius', 0):.2f}")
        with col3:
            st.metric("Minor Radius", f"{field_metrics.get('minor_radius', 0):.2f}")
        with col4:
            diversity = field_metrics.get('insight_diversity', 0)
            st.metric("Insight Diversity", f"{diversity:.1%}")
    else:
        # Default field when no processing yet
        st.info("Observation Deck awaiting first processing...")
        default_fig = create_toroidal_visualization(None, FIELD_VISUAL_HEIGHT)
        st.plotly_chart(default_fig, use_container_width=True)
    
    st.markdown('</div>', unsafe_allow_html=True)

# ==================== PROCESSING RESULTS ====================
if st.session_state.processing_history:
    latest_result = st.session_state.processing_history[-1]
    
    # Create tabs for different views
    tab1, tab2, tab3 = st.tabs(["⚖️ 3+1 Insights", "🎯 Consensus", "💎 000 Output"])
    
    with tab1:
        # 3+1 INSIGHTS DISPLAY
        st.markdown("### ⚖️ Council 5.1 - 3+1 Insights")
        
        if "balanced_insights" in latest_result["council_report"]:
            insights = latest_result["council_report"]["balanced_insights"]
            
            # Display each seat's insights
            for seat_name, insight_obj in insights.items():
                # Determine card style
                card_class = "insight-card"
                if seat_name == "Heavy Hauler":
                    card_class += " heavy-hauler-card"
                
                with st.container():
                    st.markdown(f'<div class="{card_class}">', unsafe_allow_html=True)
                    
                    # Seat header with badges
                    col1, col2, col3 = st.columns([3, 1, 1])
                    with col1:
                        st.markdown(f"""
                        <div class="seat-header">
                            <span class="resonance-badge">3 Resonance</span>
                            <span class="anchor-badge">1 Anchor</span>
                            <strong>{seat_name}</strong>
                        </div>
                        """, unsafe_allow_html=True)
                    
                    with col2:
                        st.metric("Confidence", f"{getattr(insight_obj, 'confidence', 0):.1%}")
                    
                    with col3:
                        if seat_name == "Heavy Hauler":
                            humor = getattr(insight_obj, 'humor_level', 0)
                            st.markdown(f'<div class="humor-badge">Humor: {humor:.0%}</div>', 
                                      unsafe_allow_html=True)
                    
                    # Display resonance points (3)
                    if show_resonance_details:
                        st.markdown("#### 🟢 Resonance Points")
                        resonance_points = getattr(insight_obj, 'resonance_points', [])
                        for i, point in enumerate(resonance_points[:3], 1):
                            point_text = point.get('point', 'No point')
                            explanation = point.get('explanation', '')
                            domain = point.get('domain', 'general')
                            
                            st.markdown(f"""
                            <div style="margin: 10px 0; padding: 10px; background: rgba(76, 175, 80, 0.05); 
                                        border-radius: 5px; border-left: 3px solid #4CAF50;">
                                <strong>#{i}:</strong> {point_text}<br>
                                <small><em>{explanation}</em></small><br>
                                <span class="metric-pill">{domain}</span>
                                <span class="metric-pill">{point.get('confidence', 0):.0%} confidence</span>
                            </div>
                            """, unsafe_allow_html=True)
                    
                    # Display static anchor (1)
                    if show_anchor_details:
                        st.markdown("#### 🟠 Static Anchor")
                        anchor = getattr(insight_obj, 'static_anchor', {})
                        
                        if anchor:
                            severity = anchor.get('severity', 0)
                            severity_color = "#4CAF50" if severity < 0.3 else "#FF9800" if severity < 0.6 else "#f44336"
                            
                            st.markdown(f"""
                            <div style="margin: 10px 0; padding: 15px; background: rgba(255, 152, 0, 0.05); 
                                        border-radius: 5px; border-left: 3px solid {severity_color};">
                                <strong>Critical Perspective:</strong> {anchor.get('point', '')}<br><br>
                                <strong>Rationale:</strong> {anchor.get('rationale', '')}<br>
                                <strong>Mitigation:</strong> {anchor.get('mitigation', 'Monitor closely')}<br>
                                <div style="display: flex; align-items: center; margin-top: 10px;">
                                    <span class="metric-pill">Severity: {severity:.1%}</span>
                                    <span class="metric-pill">{anchor.get('domain', 'general')}</span>
                                </div>
                            </div>
                            """, unsafe_allow_html=True)
                    
                    st.markdown('</div>', unsafe_allow_html=True)
                    st.markdown("---")
        
        else:
            st.warning("No balanced insights available in this result")
    
    with tab2:
        # CONSENSUS VIEW
        st.markdown("### 🎯 Balanced Consensus")
        
        consensus = latest_result["council_report"].get("consensus_report", {})
        council_metrics = latest_result["council_report"].get("council_metrics", {})
        
        # Display consensus
        st.info(consensus.get("primary_consensus", "No consensus reached"))
        
        # Display metrics
        col1, col2, col3 = st.columns(3)
        with col1:
            st.metric("Consensus Confidence", f"{consensus.get('confidence_score', 0):.1%}")
        with col2:
            st.metric("Balance Score", f"{council_metrics.get('balance_score', 0):.1%}")
        with col3:
            st.metric("Insight Diversity", f"{council_metrics.get('insight_diversity', 0):.1%}")
        
        # Display resonance themes
        if "resonance_themes" in consensus:
            st.markdown("#### 🟢 Key Resonance Themes")
            themes = consensus["resonance_themes"]
            theme_cols = st.columns(min(3, len(themes)))
            for col, theme in zip(theme_cols, themes[:3]):
                with col:
                    st.markdown(f"""
                    <div style="text-align: center; padding: 15px; background: rgba(76, 175, 80, 0.1); 
                                border-radius: 10px; margin: 5px;">
                        <strong>{theme}</strong>
                    </div>
                    """, unsafe_allow_html=True)
        
        # Display critical anchors
        if "critical_anchors" in consensus and consensus["critical_anchors"]:
            st.markdown("#### 🟠 Critical Anchors")
            for i, anchor in enumerate(consensus["critical_anchors"][:2], 1):
                with st.expander(f"Anchor #{i}: {anchor.get('seat', 'Unknown')}", expanded=i==1):
                    st.markdown(f"""
                    **Point:** {anchor.get('point', '')}
                    
                    **Severity:** {anchor.get('severity', 0):.1%}
                    
                    **Mitigation:** {anchor.get('mitigation', 'Monitor closely')}
                    """)
    
    with tab3:
        # 000 OUTPUT
        st.markdown("### 💎 000 Balanced Output")
        
        purified = latest_result.get("purified_output_000", "No output generated")
        st.markdown(purified)
        
        # Download button
        st.download_button(
            label="📥 Download Balanced Output",
            data=purified,
            file_name=f"orion_balanced_output_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md",
            mime="text/markdown",
            use_container_width=True
        )

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
        st.caption(f"⚖️ Balance: {balance:.1%}")
with footer_cols[3]:
    st.caption("🌀 Orion Chronicles v5.1")

# ==================== ASYNC SUPPORT ====================
def start_async_loop():
    """Start async event loop in background thread"""
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_forever()

# Start async thread if needed
if 'async_thread' not in st.session_state or not st.session_state.async_thread:
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
    pass