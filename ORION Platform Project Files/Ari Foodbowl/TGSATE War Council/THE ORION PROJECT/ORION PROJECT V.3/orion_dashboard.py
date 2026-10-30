"""
ORION DASHBOARD v3.0 - Production Streamlit Interface
Run: streamlit run orion_dashboard.py
"""

import streamlit as st
import asyncio
import json
import plotly.graph_objects as go
from datetime import datetime
import sys
import os
import numpy as np  # MUST BE AT TOP LEVEL
import traceback

# ==================== GLOBAL CONSTANTS ====================
# These MUST be defined before any function calls
TOROIDAL_RADIUS = 1.5
J3_STABILITY_TARGET = 0.997
REP_EFFICIENCY_TARGET = 0.982
J3_SPIRIT_CONSTANT = 2.718281828459045
REP_EFFICIENCY_THRESHOLD = 0.85
CONSENSUS_THRESHOLD = 0.7

# ==================== STREAMLIT CONFIGURATION ====================
# This must come BEFORE any st. calls
st.set_page_config(
    page_title="Orion Chronicles Command Deck",
    page_icon="🌀",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ==================== CUSTOM CSS ====================
st.markdown("""
<style>
    .main-header {
        font-size: 3.5rem;
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        padding: 20px;
        margin-bottom: 30px;
    }
    .metric-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 15px;
        padding: 20px;
        color: white;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        margin: 10px 0;
    }
    .stTextArea textarea {
        border-radius: 10px;
        border: 2px solid #667eea;
        font-size: 16px;
        padding: 15px;
    }
    .process-button {
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 25px;
        padding: 15px 30px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    .process-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
    }
    .seed-card {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
        padding: 15px;
        margin: 10px 0;
        border-left: 5px solid #764ba2;
    }
    .engine-offline {
        background: linear-gradient(135deg, #ff6b6b 0%, #c92a2a 100%);
        color: white;
        padding: 15px;
        border-radius: 10px;
        text-align: center;
        margin: 10px 0;
    }
</style>
""", unsafe_allow_html=True)

# ==================== SESSION STATE INITIALIZATION ====================
# Initialize all session state variables BEFORE any conditional logic
if 'current_session' not in st.session_state:
    st.session_state.current_session = None
if 'processing_history' not in st.session_state:
    st.session_state.processing_history = []
if 'resonant_seeds' not in st.session_state:
    st.session_state.resonant_seeds = []
if 'user_id' not in st.session_state:
    st.session_state.user_id = f"user_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
if 'async_thread' not in st.session_state:
    st.session_state.async_thread = None
if 'initialized' not in st.session_state:
    st.session_state.initialized = False
if 'engine_initialized' not in st.session_state:
    st.session_state.engine_initialized = False
if 'engine_error' not in st.session_state:
    st.session_state.engine_error = None

# ==================== GLOBAL ENGINE INITIALIZATION ====================
# Initialize engine globally at module level
@st.cache_resource
def get_orion_engine_singleton():
    """
    Global singleton engine initialization
    This runs once and caches the result for the entire session
    """
    engine = None
    error_msg = None
    
    try:
        # Add core to path
        core_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'core')
        if core_path not in sys.path:
            sys.path.append(core_path)
        
        # Check if core module exists
        core_init = os.path.join(core_path, '__init__.py')
        engine_file = os.path.join(core_path, 'orion_engine.py')
        
        if not os.path.exists(engine_file):
            error_msg = f"Engine file not found: {engine_file}"
            st.error(f"❌ {error_msg}")
        else:
            # Import the engine module
            import importlib.util
            spec = importlib.util.spec_from_file_location("orion_engine", engine_file)
            orion_module = importlib.util.module_from_spec(spec)
            
            try:
                spec.loader.exec_module(orion_module)
                
                # Create mock database pool
                class MockDBPool:
                    def __init__(self):
                        self._closed = False
                    
                    async def acquire(self):
                        class MockConnection:
                            async def execute(self, query, *args):
                                return None
                            async def fetch(self, query, *args):
                                return []
                            async def fetchrow(self, query, *args):
                                return None
                            async def close(self):
                                pass
                        return MockConnection()
                    
                    async def release(self, conn):
                        await conn.close()
                    
                    async def close(self):
                        self._closed = True
                
                # Get the engine instance
                if hasattr(orion_module, 'get_orion_engine'):
                    engine = orion_module.get_orion_engine(MockDBPool())
                    st.success("✅ Orion Engine initialized successfully!")
                else:
                    # Create mock engine if get_orion_engine not found
                    error_msg = "get_orion_engine function not found in module"
                    st.warning("⚠️ Using mock engine (full engine not available)")
                    
                    # Create a simple mock engine
                    class MockOrionEngine:
                        def __init__(self):
                            self.metrics = {
                                "j3_stability": 0.95,
                                "rep_efficiency": 0.88,
                                "active_sessions": 0,
                                "total_seeds": 0,
                                "consensus_rate": 0.85,
                                "ghost_activations": 0,
                                "uptime": datetime.utcnow()
                            }
                        
                        def get_system_metrics(self):
                            # Add some randomness to make it look alive
                            import random
                            self.metrics.update({
                                "j3_stability": 0.95 + random.uniform(-0.02, 0.02),
                                "rep_efficiency": 0.88 + random.uniform(-0.03, 0.03),
                                "uptime_seconds": (datetime.utcnow() - self.metrics["uptime"]).total_seconds()
                            })
                            return self.metrics
                        
                        def get_toroidal_field(self):
                            # Generate toroidal field data
                            detail = 30
                            theta = np.linspace(0, 2 * np.pi, detail)
                            phi = np.linspace(0, 2 * np.pi, detail)
                            theta, phi = np.meshgrid(theta, phi)
                            
                            R = TOROIDAL_RADIUS * self.metrics["j3_stability"]
                            r = 0.4 * self.metrics["rep_efficiency"]
                            
                            x = (R + r * np.cos(theta)) * np.cos(phi)
                            y = (R + r * np.cos(theta)) * np.sin(phi)
                            z = r * np.sin(theta)
                            
                            return {
                                "x": x.tolist(),
                                "y": y.tolist(),
                                "z": z.tolist(),
                                "type": "surface",
                                "colorscale": [
                                    [0.0, 'rgb(100, 0, 150)'],
                                    [0.5, 'rgb(0, 150, 200)'],
                                    [1.0, 'rgb(0, 200, 100)']
                                ],
                                "opacity": 0.7,
                                "showscale": True
                            }
                        
                        async def create_user_session(self, user_id: str):
                            # Create a mock user session
                            class MockUserSession:
                                def __init__(self, user_id):
                                    self.session_id = f"session-{user_id}-{datetime.now().strftime('%H%M%S')}"
                                    self.user_id = user_id
                                    self.player_stats = type('obj', (object,), {
                                        'resonance_frequency': 0.5,
                                        'total_seeds': 0,
                                        'total_collaborations': 0,
                                        'avg_rep_efficiency': 0.0,
                                        'j3_mastery': {
                                            'epigenetic': 0.5,
                                            'neurological': 0.5,
                                            'quantum': 0.5
                                        },
                                        'expertise_domains': ['mycelial_bridging', 'quantum_logic']
                                    })()
                                
                                async def process_input(self, raw_input: str):
                                    # Simulate processing
                                    await asyncio.sleep(0.5)
                                    
                                    # Create mock results
                                    import hashlib
                                    input_hash = hashlib.sha256(raw_input.encode()).hexdigest()[:8]
                                    
                                    return {
                                        "session_id": self.session_id,
                                        "user_id": self.user_id,
                                        "timestamp": datetime.utcnow().isoformat(),
                                        "ghost_rider": {
                                            "activated": False,
                                            "details": {"transformations": []},
                                            "transformed_input": None
                                        },
                                        "rep_result": {
                                            "rep_id": f"REP-{input_hash}",
                                            "entropy_score": 0.3,
                                            "rind_components": {"rind_mass": 0.1},
                                            "j3_applied": {
                                                "epigenetic": "Cleared limiting patterns",
                                                "neurological": "Reframed perspectives",
                                                "quantum": "Applied superposition"
                                            },
                                            "purified_seed": f"Purified insight: {raw_input[:100]}...",
                                            "efficiency_score": 0.85
                                        },
                                        "council_consensus": {
                                            "primary_consensus": f"Council analyzed: '{raw_input[:50]}...' and recommends quantum-mycelial integration.",
                                            "confidence_score": 0.87,
                                            "council_responses": [
                                                {
                                                    "agent": "Gemini (Ferrari)",
                                                    "response": "Accelerate with high-frequency insights!",
                                                    "confidence": 0.9
                                                },
                                                {
                                                    "agent": "DeepSeek (Engineer)",
                                                    "response": "Structural integrity confirmed for implementation.",
                                                    "confidence": 0.85
                                                }
                                            ]
                                        },
                                        "mycelial_seed_id": f"SEED-{input_hash}"
                                    }
                                
                                async def get_resonant_seeds(self, limit: int = 3):
                                    # Return mock seeds
                                    class MockSeed:
                                        def __init__(self, idx):
                                            self.seed_id = f"SEED-MOCK-{idx}"
                                            self.resonance_score = 0.5 + (idx * 0.1)
                                            self.collaborators = []
                                            self.purified_seed = f"Seed content {idx}: Exploring quantum consciousness bridges..."
                                            self.j3_completion = {
                                                'epigenetic': idx == 0,
                                                'neurological': idx == 1,
                                                'quantum': idx == 2
                                            }
                                            self.is_harvested = False
                                    
                                    return [MockSeed(i) for i in range(min(limit, 3))]
                            
                            session = MockUserSession(user_id)
                            self.metrics["active_sessions"] += 1
                            return session
                    
                    engine = MockOrionEngine()
                    
            except Exception as e:
                error_msg = f"Engine module import failed: {str(e)}"
                st.error(f"❌ {error_msg}")
                print(f"Debug: {traceback.format_exc()}")
                
                # Create emergency mock engine
                engine = None
    
    except Exception as e:
        error_msg = f"Engine initialization failed: {str(e)}"
        st.error(f"❌ {error_msg}")
        print(f"Debug: {traceback.format_exc()}")
        engine = None
    
    # Store error in session state for display
    if error_msg:
        st.session_state.engine_error = error_msg
    
    return engine, error_msg

# ==================== GLOBAL ENGINE INSTANCE ====================
# This creates the engine instance once and stores it
try:
    if 'global_engine' not in st.session_state:
        st.session_state.global_engine, st.session_state.engine_error = get_orion_engine_singleton()
        st.session_state.engine_initialized = st.session_state.global_engine is not None
    else:
        # Use cached engine
        pass
except Exception as e:
    st.session_state.engine_error = f"Engine setup failed: {str(e)}"
    st.session_state.global_engine = None
    st.session_state.engine_initialized = False

# Set engine variable for global access
engine = st.session_state.get('global_engine', None)

# ==================== HELPER FUNCTIONS ====================
def get_system_metrics_fallback():
    """Fallback system metrics if engine is not available"""
    return {
        "j3_stability": 0.95,
        "rep_efficiency": 0.88,
        "active_sessions": 0,
        "total_seeds": 0,
        "consensus_rate": 0.85,
        "ghost_activations": 0,
        "uptime": datetime.utcnow().isoformat(),
        "uptime_seconds": 3600
    }

def get_toroidal_field_fallback():
    """Fallback toroidal field data"""
    detail = 30
    R = TOROIDAL_RADIUS * 0.95
    r = 0.4
    
    theta = np.linspace(0, 2 * np.pi, detail)
    phi = np.linspace(0, 2 * np.pi, detail)
    theta, phi = np.meshgrid(theta, phi)
    
    x = (R + r * np.cos(theta)) * np.cos(phi)
    y = (R + r * np.cos(theta)) * np.sin(phi)
    z = r * np.sin(theta)
    
    return {
        "x": x.tolist(),
        "y": y.tolist(),
        "z": z.tolist(),
        "type": "surface",
        "colorscale": [
            [0.0, 'rgb(100, 0, 150)'],
            [0.5, 'rgb(0, 150, 200)'],
            [1.0, 'rgb(0, 200, 100)']
        ],
        "opacity": 0.7,
        "showscale": True
    }

# ==================== SIDEBAR - USER SESSION SECTION ====================
with st.sidebar:
    st.markdown("## 🎮 Control Panel")
    
    # Engine Status Display
    if st.session_state.engine_error:
        st.markdown(f"""
        <div class="engine-offline">
        ⚠️ ENGINE OFFLINE<br>
        <small>{st.session_state.engine_error[:100]}...</small>
        </div>
        """, unsafe_allow_html=True)
    elif not st.session_state.engine_initialized:
        st.markdown("""
        <div class="engine-offline">
        🔄 ENGINE INITIALIZING...
        </div>
        """, unsafe_allow_html=True)
    else:
        st.markdown("""
        <div style="background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%); 
                    color: white; padding: 15px; border-radius: 10px; text-align: center;">
        ✅ ENGINE ONLINE
        </div>
        """, unsafe_allow_html=True)
    
    # User Session Management
    st.markdown("### 👤 User Session")
    
    # Create session button - ALWAYS ENABLED
    if st.button("🔄 New Session", use_container_width=True, key="new_session_btn"):
        if engine is None:
            st.error("Engine not available. Cannot create session.")
        else:
            # Show spinner while creating session
            with st.spinner("Creating new session..."):
                async def create_session():
                    try:
                        # Ensure we have a valid engine
                        current_engine = st.session_state.get('global_engine')
                        if not current_engine:
                            st.error("Engine instance lost. Please refresh.")
                            return
                        
                        # Create session with the engine
                        session = await current_engine.create_user_session(st.session_state.user_id)
                        st.session_state.current_session = session
                        st.session_state.processing_history = []
                        st.session_state.resonant_seeds = []
                        st.rerun()
                    except Exception as e:
                        st.error(f"Session creation failed: {str(e)[:100]}")
                        print(f"Session creation error: {traceback.format_exc()}")
                
                # Run the async function
                asyncio.run(create_session())
    
    # Display session status
    if st.session_state.current_session:
        session = st.session_state.current_session
        session_id = getattr(session, 'session_id', 'unknown')
        st.success(f"✅ Session Active: {session_id[:12]}")
        
        # Player Stats Display
        st.markdown("#### 📊 Player Stats")
        stats = session.player_stats
        
        col1, col2 = st.columns(2)
        with col1:
            resonance = getattr(stats, 'resonance_frequency', 0.5)
            total_seeds = getattr(stats, 'total_seeds', 0)
            st.metric("Resonance", f"{resonance:.3f}")
            st.metric("Seeds", total_seeds)
        
        with col2:
            collaborations = getattr(stats, 'total_collaborations', 0)
            rep_eff = getattr(stats, 'avg_rep_efficiency', 0.0)
            st.metric("Collaborations", collaborations)
            st.metric("REP Eff.", f"{rep_eff:.1%}")
        
        # J3 Mastery
        st.markdown("##### J=3 Mastery")
        j3_mastery = getattr(stats, 'j3_mastery', {'epigenetic': 0.5, 'neurological': 0.5, 'quantum': 0.5})
        for domain, mastery in j3_mastery.items():
            st.progress(mastery, text=f"{domain.title()}: {mastery:.0%}")
    else:
        st.info("No active session. Click 'New Session' to begin.")
    
    # System Metrics
    st.markdown("### 📈 System Health")
    
    # Get metrics from engine or fallback
    try:
        if engine and hasattr(engine, 'get_system_metrics'):
            metrics = engine.get_system_metrics()
        else:
            metrics = get_system_metrics_fallback()
    except:
        metrics = get_system_metrics_fallback()
    
    col1, col2 = st.columns(2)
    with col1:
        j3_stability = metrics.get('j3_stability', 0.95)
        delta_j3 = f"{((j3_stability/J3_STABILITY_TARGET)-1):+.1%}" if J3_STABILITY_TARGET else None
        st.metric("J=3 Stability", f"{j3_stability:.2%}", delta=delta_j3)
    
    with col2:
        rep_efficiency = metrics.get('rep_efficiency', 0.88)
        delta_rep = f"{((rep_efficiency/REP_EFFICIENCY_TARGET)-1):+.1%}" if REP_EFFICIENCY_TARGET else None
        st.metric("REP Efficiency", f"{rep_efficiency:.2%}", delta=delta_rep)
    
    stability_progress = j3_stability if 'j3_stability' in metrics else 0.95
    st.progress(stability_progress, text="System Integrity")
    
    # Active Users
    active_users = metrics.get('active_sessions', 0)
    st.metric("Active Users", active_users)
    
    # Field Controls
    st.markdown("### 🌀 Field Controls")
    field_opacity = st.slider("Opacity", 0.1, 1.0, 0.7, key="field_opacity")
    field_rotation = st.slider("Rotation", 0, 10, 3, key="field_rotation")
    
    # Ghost Rider Toggle
    st.markdown("### 👻 Ghost Rider")
    gr_enabled = st.toggle("Active", value=True, key="ghost_rider_toggle")
    
    # Mycelial Highway
    st.markdown("### 🌐 Mycelial Highway")
    find_disabled = not st.session_state.current_session or engine is None
    
    if st.button("🔍 Find Resonant Seeds", 
                use_container_width=True, 
                disabled=find_disabled,
                key="find_seeds_btn"):
        
        if st.session_state.current_session and engine:
            with st.spinner("Searching for resonant seeds..."):
                async def find_seeds():
                    try:
                        session = st.session_state.current_session
                        if hasattr(session, 'get_resonant_seeds'):
                            seeds = await session.get_resonant_seeds(limit=5)
                            st.session_state.resonant_seeds = seeds
                            st.rerun()
                        else:
                            st.error("Session missing get_resonant_seeds method")
                    except Exception as e:
                        st.error(f"Failed to find seeds: {str(e)[:100]}")
                        print(f"Find seeds error: {traceback.format_exc()}")
                
                asyncio.run(find_seeds())
        else:
            st.warning("Need active session and engine")

# ==================== MAIN DASHBOARD ====================
st.markdown('<div class="main-header">🌀 Orion Chronicles Command Deck</div>', unsafe_allow_html=True)

# Two-column layout
col_left, col_right = st.columns([2, 1])

with col_left:
    # ==================== SPAGHETTI DUMP INPUT ====================
    st.markdown("### 🍝 Spaghetti Brain Dump")
    
    spaghetti_input = st.text_area(
        "Enter your raw thoughts, ideas, questions, or creative chaos:",
        height=200,
        placeholder="""Type anything here... The Orion Engine will:
1. 🛡️ Ghost Rider: Scan & transform destructive patterns
2. 🧬 REP Engine: Process through 144 => R => J=3 => 000
3. 🏛️ AI Council: Four specialized AIs debate & consensus
4. 🌐 Mycelial: Deposit purified seed to global vault""",
        key="spaghetti_input",
        help="Maximum 5000 characters"
    )
    
    # Process Button - DYNAMICALLY ENABLED/DISABLED
    process_disabled = not spaghetti_input or not st.session_state.current_session or engine is None
    
    if st.button("🚀 PROCESS THROUGH ORION ENGINE", 
                 type="primary", 
                 use_container_width=True,
                 disabled=process_disabled,
                 key="process_btn"):
        
        if spaghetti_input and st.session_state.current_session and engine:
            with st.spinner("Orion Engine Processing..."):
                # Process through full pipeline
                session = st.session_state.current_session
                
                async def process():
                    try:
                        if hasattr(session, 'process_input'):
                            return await session.process_input(spaghetti_input)
                        else:
                            st.error("Session missing process_input method")
                            return None
                    except Exception as e:
                        st.error(f"Processing failed: {str(e)[:200]}")
                        print(f"Process error: {traceback.format_exc()}")
                        return None
                
                result = asyncio.run(process())
                if result:
                    st.session_state.processing_history.append(result)
                    st.success("✅ Processing Complete!")
                    st.balloons()
                else:
                    st.error("Processing failed. Check console for details.")
        elif not st.session_state.current_session:
            st.warning("Please start a new session first!")
        elif engine is None:
            st.error("Engine is offline. Cannot process.")
    
    # ==================== PROCESSING RESULTS ====================
    if st.session_state.processing_history:
        latest_result = st.session_state.processing_history[-1]
        
        st.markdown("## 📊 Latest Processing Results")
        
        # Ghost Rider Status
        if latest_result.get('ghost_rider', {}).get('activated'):
            st.warning("""
            👻 **Ghost Rider Protocol Activated**
            Destructive patterns were alchemically transformed for safety.
            """)
        
        # REP Analysis
        if 'rep_result' in latest_result:
            with st.expander("🧬 REP Engine Analysis", expanded=True):
                rep = latest_result['rep_result']
                
                col1, col2, col3 = st.columns(3)
                with col1:
                    entropy = rep.get('entropy_score', 0)
                    st.metric("Entropy", f"{entropy:.3f}")
                with col2:
                    rind_mass = rep.get('rind_components', {}).get('rind_mass', 0)
                    st.metric("Rind Mass", f"{rind_mass:.3f}")
                with col3:
                    efficiency = rep.get('efficiency_score', 0)
                    st.metric("Efficiency", f"{efficiency:.2%}")
                
                # Purified Seed Display
                if 'purified_seed' in rep:
                    st.markdown("##### Purified Seed (000 Output):")
                    st.info(rep['purified_seed'])
                
                # J3 Application Details
                if 'j3_applied' in rep:
                    st.markdown("##### J=3 Triune Torque Applied:")
                    for torque_type, application in rep['j3_applied'].items():
                        st.caption(f"**{torque_type.title()}:** {application}")
        
        # Council Consensus
        if 'council_consensus' in latest_result:
            with st.expander("🏛️ AI Council Consensus", expanded=True):
                consensus = latest_result['council_consensus']
                
                confidence = consensus.get('confidence_score', 0)
                st.metric("Consensus Confidence", f"{confidence:.2%}")
                
                if 'primary_consensus' in consensus:
                    st.markdown("##### Primary Consensus:")
                    st.success(consensus['primary_consensus'])
                
                # Alternative Paths
                if 'alternative_paths' in consensus and consensus['alternative_paths']:
                    st.markdown("##### Alternative Trajectories:")
                    for i, path in enumerate(consensus['alternative_paths'], 1):
                        st.text_area(f"Path {i}", path, height=60, disabled=True, key=f"path_{i}")
                
                # Individual Responses
                if 'council_responses' in consensus:
                    st.markdown("##### Individual Council Responses:")
                    for response in consensus['council_responses']:
                        with st.expander(f"{response.get('agent', 'Unknown')} (Confidence: {response.get('confidence', 0):.0%})"):
                            st.write(response.get('response', 'No response'))
        
        # Mycelial Deposit
        seed_id = latest_result.get('mycelial_seed_id')
        if seed_id:
            st.success(f"🌱 **Seed Planted to Mycelial Highway:** `{seed_id}`")
    
    # ==================== PROCESSING HISTORY ====================
    if len(st.session_state.processing_history) > 1:
        st.markdown("## 📜 Processing History")
        history_to_show = list(reversed(st.session_state.processing_history[-5:]))
        for i, result in enumerate(history_to_show):
            with st.expander(f"Processing {i+1}: {result.get('timestamp', '')[11:19]}"):
                eff = result.get('rep_result', {}).get('efficiency_score', 0)
                st.caption(f"Efficiency: {eff:.2%}")
                seed = result.get('rep_result', {}).get('purified_seed', '')
                st.caption(f"Seed: {seed[:100]}..." if seed else "No seed")

with col_right:
    # ==================== TOROIDAL FIELD VISUALIZATION ====================
    st.markdown("### 🌀 Toroidal Energy Field")
    
    # Get current field data
    try:
        if engine and hasattr(engine, 'get_toroidal_field'):
            field_data = engine.get_toroidal_field()
        else:
            field_data = get_toroidal_field_fallback()
    except:
        field_data = get_toroidal_field_fallback()
    
    # Create 3D plot
    try:
        fig = go.Figure(data=[go.Surface(
            x=field_data.get("x", []),
            y=field_data.get("y", []),
            z=field_data.get("z", []),
            colorscale=field_data.get("colorscale", "Viridis"),
            opacity=field_opacity,
            showscale=field_data.get("showscale", True),
            contours={
                "x": {"show": True, "color": "white", "width": 1},
                "y": {"show": True, "color": "white", "width": 1},
                "z": {"show": True, "color": "white", "width": 1}
            }
        )])
        
        # Update layout
        camera = dict(
            eye=dict(
                x=1.5 * np.cos(field_rotation * 0.1),
                y=1.5 * np.sin(field_rotation * 0.1),
                z=1.2
            )
        )
        
        fig.update_layout(
            title="J=3 Spirit Constant Field",
            scene=dict(
                xaxis_title="Epigenetic Axis",
                yaxis_title="Neurological Axis",
                zaxis_title="Quantum Axis",
                camera=camera,
                aspectmode="data"
            ),
            width=450,
            height=450,
            margin=dict(l=0, r=0, t=40, b=0),
            paper_bgcolor="rgba(0,0,0,0)",
            plot_bgcolor="rgba(0,0,0,0)"
        )
        
        st.plotly_chart(fig, use_container_width=True)
        
        # Field Metrics
        try:
            if engine and hasattr(engine, 'get_system_metrics'):
                metrics = engine.get_system_metrics()
            else:
                metrics = get_system_metrics_fallback()
        except:
            metrics = get_system_metrics_fallback()
            
        col1, col2 = st.columns(2)
        with col1:
            field_radius = TOROIDAL_RADIUS * metrics.get('j3_stability', 0.95)
            st.metric("Field Radius", f"{field_radius:.1f}")
        with col2:
            field_strength = metrics.get('rep_efficiency', 0.88)
            st.metric("Field Strength", f"{field_strength:.2%}")
    
    except Exception as e:
        st.error(f"Failed to render toroidal field: {str(e)[:100]}")
        st.info("Using fallback visualization")
    
    # ==================== RESONANT SEEDS ====================
    if st.session_state.resonant_seeds:
        st.markdown("### 🌟 Resonant Seeds for You")
        
        for seed in st.session_state.resonant_seeds[:3]:
            with st.container():
                seed_id = getattr(seed, 'seed_id', 'unknown')
                resonance = getattr(seed, 'resonance_score', 0)
                collaborators = getattr(seed, 'collaborators', [])
                
                st.markdown(f"""
                <div class="seed-card">
                <strong>{seed_id[:12] if seed_id else 'unknown'}</strong><br>
                <small>Resonance: {resonance:.2f}</small><br>
                <small>Collaborators: {len(collaborators)}</small>
                </div>
                """, unsafe_allow_html=True)
    
    # ==================== QUICK ACTIONS ====================
    st.markdown("### ⚡ Quick Actions")
    
    if st.button("📊 Update Metrics", use_container_width=True, key="update_metrics_btn"):
        st.rerun()
    
    if st.button("🧹 Clear History", use_container_width=True, key="clear_history_btn"):
        st.session_state.processing_history = []
        st.session_state.resonant_seeds = []
        st.rerun()
    
    # ==================== SYSTEM STATUS ====================
    st.markdown("### 🔧 System Status")
    
    status_cols = st.columns(2)
    with status_cols[0]:
        try:
            if engine and hasattr(engine, 'get_system_metrics'):
                metrics = engine.get_system_metrics()
            else:
                metrics = get_system_metrics_fallback()
        except:
            metrics = get_system_metrics_fallback()
            
        active_sessions = metrics.get('active_sessions', 0)
        st.metric("Active Sessions", active_sessions)
    
    with status_cols[1]:
        uptime = metrics.get('uptime_seconds', 0)
        st.metric("Uptime", f"{uptime/3600:.1f}h")

# ==================== FOOTER ====================
st.markdown("---")
footer_cols = st.columns(4)
with footer_cols[0]:
    st.caption(f"🆔 User: {st.session_state.user_id}")
with footer_cols[1]:
    st.caption(f"🕐 System Time: {datetime.now().strftime('%H:%M:%S')}")
with footer_cols[2]:
    engine_status = "🟢 ONLINE" if st.session_state.engine_initialized else "🔴 OFFLINE"
    st.caption(f"Engine: {engine_status}")
with footer_cols[3]:
    session_status = "🟢 ACTIVE" if st.session_state.current_session else "🟠 STANDBY"
    st.caption(f"Session: {session_status}")

# ==================== ASYNC SUPPORT ====================
import threading

def start_async_loop():
    """Start async event loop in background thread"""
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_forever()

# Start async thread if not already running
if st.session_state.async_thread is None or not st.session_state.async_thread.is_alive():
    try:
        thread = threading.Thread(target=start_async_loop, daemon=True)
        thread.start()
        st.session_state.async_thread = thread
    except:
        pass

# ==================== INITIALIZATION COMPLETE ====================
if not st.session_state.initialized:
    st.session_state.initialized = True
    if st.session_state.engine_initialized:
        st.toast("🌀 Orion Chronicles Command Deck Initialized!", icon="✅")
    else:
        st.toast("⚠️ Orion Chronicles in Fallback Mode", icon="⚡")

if __name__ == "__main__":
    # This ensures the script runs cleanly
    pass