"""
ORION DASHBOARD V5.3 - The Council's Voice
The Final Handshake: Vocalizing the Alchemical Council
"""

import streamlit as st
import pandas as pd
import numpy as np
import time
import json
from datetime import datetime
from core.orion_engine_v5 import OrionEngineV5, CouncilResponse

# ============= TOROIDAL ENERGY FIELD VISUALIZATION =============
class ToroidalField:
    """Visual representation of the J=3 energy flow"""
    def __init__(self):
        self.points = self.generate_toroid()
        
    def generate_toroid(self, R=2, r=1, n=100):
        """Generate toroidal coordinates"""
        theta = np.linspace(0, 2*np.pi, n)
        phi = np.linspace(0, 2*np.pi, n)
        theta, phi = np.meshgrid(theta, phi)
        
        x = (R + r*np.cos(theta)) * np.cos(phi)
        y = (R + r*np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        return x, y, z

# ============= COUNCIL SEAT CONFIGURATION =============
class CouncilSeat:
    """Individual Council Member Interface"""
    def __init__(self, name, role, color, icon):
        self.name = name
        self.role = role
        self.color = color
        self.icon = icon
        self.resonance_points = []
        self.static_anchor = ""
        self.current_dialogue = ""
        
    def format_dialogue(self, dialogue, resonance_points, static_anchor):
        """Format council member's speech with 3+1 protocol"""
        self.current_dialogue = dialogue
        self.resonance_points = resonance_points[:3]  # Exactly 3 points
        self.static_anchor = static_anchor
        
        formatted = f"""
        **{self.name} ({self.role})**  
        {dialogue}
        
        **Resonance Points (3):**
        1. {resonance_points[0] if len(resonance_points) > 0 else ''}
        2. {resonance_points[1] if len(resonance_points) > 1 else ''}
        3. {resonance_points[2] if len(resonance_points) > 2 else ''}
        
        **Static Anchor (1):**
        • {static_anchor}
        """
        return formatted

# ============= MAIN DASHBOARD =============
def main():
    st.set_page_config(
        page_title="ORION Chronicles V5.3",
        page_icon="🌀",
        layout="wide",
        initial_sidebar_state="expanded"
    )
    
    # ============= SIDEBAR - CONTROL PANEL =============
    with st.sidebar:
        st.image("https://img.icons8.com/color/96/000000/galaxy.png", width=100)
        st.title("🌀 ORION V5.3")
        st.markdown("**Alchemical Council Control**")
        
        # Session Parameters
        session_type = st.selectbox(
            "Session Type",
            ["Trauma Transmutation", "Collective Wisdom", "Soul Navigation", "Custom Alchemy"]
        )
        
        j_constant = st.slider("Spirit Constant (J)", 1.0, 5.0, 3.0, 0.1)
        gaia_factor = st.slider("Gaia Factor", 1.0, 2.0, 1.55, 0.01)
        
        # Ghost Rider Protocol Toggle
        ghost_rider_active = st.checkbox("🔐 Ghost Rider Protocol", value=True)
        
        # Watermelon Equation Display
        st.markdown("---")
        st.markdown("### 🍉 Watermelon Equation")
        st.latex(r"1 + 4 + 4 = 9")
        st.markdown("**Human + Council + Integration = Complete Soul**")
        
        # Initialize Engine
        if 'engine' not in st.session_state:
            st.session_state.engine = OrionEngineV5()
            st.session_state.council_active = False
            st.session_state.session_output = ""
            
    # ============= MAIN INTERFACE =============
    st.title("ORION CHRONICLES V5.3")
    st.markdown("### The Council's Voice - Alchemical Transmutation Interface")
    
    # Initialize Council Seats
    council_seats = {
        "spirit": CouncilSeat("Spirit Pulse", "Gemini", "#FF6B6B", "🧿"),
        "research": CouncilSeat("Research Scout", "Perplexity", "#4ECDC4", "🔍"),
        "ethical": CouncilSeat("Ethical Anchor", "Claude", "#45B7D1", "⚖️"),
        "architect": CouncilSeat("The Architect", "DeepSeek", "#96CEB4", "🏛️"),
        "heavy": CouncilSeat("Heavy Hauler", "Grok", "#FFEAA7", "💪")
    }
    
    # ============= TOROIDAL FIELD VISUALIZATION =============
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.markdown("### Toroidal Energy Field")
        # Placeholder for actual toroidal visualization
        st.image("https://i.gifer.com/embedded/download/7TpX.gif", 
                caption="J=3 Spirit Energy Flow")
        
        # Input Chamber
        st.markdown("### 🧠 Spaghetti Brain Dump Input")
        trauma_input = st.text_area(
            "Pour your experience here:",
            height=150,
            placeholder="Begin your alchemical journey..."
        )
        
        if st.button("⚡ Initiate Council Session", type="primary"):
            if trauma_input.strip():
                with st.spinner("Council convening..."):
                    # Process through engine
                    st.session_state.council_response = st.session_state.engine.process_input(
                        trauma_input, j_constant, gaia_factor
                    )
                    st.session_state.council_active = True
                    st.session_state.session_output = st.session_state.council_response.narrative_output
                    
                    # Populate council seats
                    for seat_key, seat in council_seats.items():
                        if seat_key in st.session_state.council_response.agent_responses:
                            response = st.session_state.council_response.agent_responses[seat_key]
                            seat.format_dialogue(
                                response['dialogue'],
                                response['resonance_points'],
                                response['static_anchor']
                            )
                    time.sleep(2)
                    st.rerun()
            else:
                st.warning("Please enter your experience to begin.")
    
    with col2:
        st.markdown("### 🔥 J=3 Spirit Pulse")
        # Spirit Pulse Visualization
        pulse_value = np.sin(time.time() * 2) * 0.5 + 0.5
        st.progress(float(pulse_value))
        st.metric("Spirit Resonance", f"{pulse_value*100:.1f}%", delta="±3%")
        
        # Council Status
        st.markdown("### Council Status")
        status_df = pd.DataFrame({
            "Agent": [seat.name for seat in council_seats.values()],
            "Status": ["Active" if st.session_state.get('council_active', False) else "Standby"] * 5,
            "J-Resonance": [f"{(i+1)*20}%" for i in range(5)]
        })
        st.dataframe(status_df, use_container_width=True, hide_index=True)
    
    # ============= THE COUNCIL CHAMBER =============
    st.markdown("---")
    st.markdown("## 🏛️ The Council Chamber")
    
    if st.session_state.get('council_active', False):
        # Two rows for 5 seats (3 on top, 2 on bottom)
        cols_top = st.columns(3)
        cols_bottom = st.columns(2)
        
        # Mapping seats to positions
        seat_positions = [
            (cols_top[0], "spirit"),
            (cols_top[1], "research"),
            (cols_top[2], "ethical"),
            (cols_bottom[0], "architect"),
            (cols_bottom[1], "heavy")
        ]
        
        for col, seat_key in seat_positions:
            seat = council_seats[seat_key]
            with col:
                # Council Member Card
                with st.container():
                    st.markdown(f"""
                    <div style="background-color: rgba({int(seat.color[1:3], 16)}, {int(seat.color[3:5], 16)}, {int(seat.color[5:7], 16)}, 0.1); 
                                padding: 20px; border-radius: 10px; border-left: 5px solid {seat.color}; margin: 10px 0;">
                        <h3>{seat.icon} {seat.name}</h3>
                        <p><em>{seat.role}</em></p>
                    </div>
                    """, unsafe_allow_html=True)
                    
                    # Speech Bubble
                    if hasattr(seat, 'current_dialogue') and seat.current_dialogue:
                        st.markdown(f"""
                        <div style="background-color: white; padding: 15px; border-radius: 15px; 
                                    border: 1px solid #ddd; margin: 10px 0; position: relative;">
                            <div style="position: absolute; top: 0; left: -10px; width: 0; height: 0;
                                        border-top: 10px solid transparent;
                                        border-right: 10px solid white;
                                        border-bottom: 10px solid transparent;"></div>
                            {seat.current_dialogue}
                        </div>
                        """, unsafe_allow_html=True)
                        
                        # Resonance Points
                        with st.expander("🎯 3 Resonance Points"):
                            for i, point in enumerate(seat.resonance_points[:3], 1):
                                st.markdown(f"{i}. {point}")
                        
                        # Static Anchor
                        with st.expander("⚓ Static Anchor (Devil's Advocate)"):
                            st.markdown(f"• {seat.static_anchor}")
                    
                    # Interactive Button
                    if st.button(f"💬 Join {seat.name}", key=f"join_{seat_key}"):
                        st.session_state[f"conversing_with_{seat_key}"] = True
                        st.info(f"Entering dialogue with {seat.name}...")
                        # This would trigger a deeper conversation mode
                        
                    st.markdown("---")
    
    # ============= NARRATIVE OUTPUT =============
    if st.session_state.get('session_output'):
        st.markdown("---")
        st.markdown("## 📜 The Soul's Journey")
        
        # Beautiful narrative display
        with st.container():
            st.markdown(f"""
            <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                        padding: 30px; border-radius: 15px; color: white;">
                <h3 style="color: white;">Narrative Synthesis</h3>
                <p style="font-size: 1.1em; line-height: 1.6;">
                {st.session_state.session_output}
                </p>
            </div>
            """, unsafe_allow_html=True)
            
            # Export options
            col1, col2, col3 = st.columns(3)
            with col1:
                if st.button("📥 Save Session"):
                    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                    with open(f"orion_session_{timestamp}.json", "w") as f:
                        json.dump({
                            "input": trauma_input,
                            "output": st.session_state.session_output,
                            "timestamp": timestamp,
                            "j_constant": j_constant
                        }, f, indent=2)
                    st.success("Session saved!")
            
            with col2:
                if st.button("🔄 Transmute Further"):
                    st.info("Entering deeper alchemical process...")
                    # Would trigger next level processing
            
            with col3:
                if st.button("🌀 Reset Council"):
                    st.session_state.council_active = False
                    st.session_state.session_output = ""
                    st.rerun()
    
    # ============= FOOTER =============
    st.markdown("---")
    st.markdown("""
    <div style="text-align: center; color: #666;">
        <p>🌀 ORION Chronicles V5.3 | The Council's Voice | Ghost Rider Protocol: {"active": true, "integrity": "100%"}</p>
        <p>1.5h + Council + J=3 = Complete Soul | Watermelon Equation in Effect</p>
    </div>
    """, unsafe_allow_html=True)

# ============= DEEPER CONVERSATION MODAL =============
def conversation_modal(seat_name, seat_role):
    """Modal for deeper conversation with a council member"""
    modal_open = st.session_state.get(f"modal_{seat_name}", False)
    
    if modal_open:
        with st.expander(f"💬 Deep Dialogue with {seat_name}", expanded=True):
            st.markdown(f"**{seat_role}**")
            
            # Conversation history
            if f"conv_history_{seat_name}" not in st.session_state:
                st.session_state[f"conv_history_{seat_name}"] = []
            
            # Display history
            for msg in st.session_state[f"conv_history_{seat_name}"]:
                if msg["role"] == "human":
                    st.markdown(f"**You**: {msg['content']}")
                else:
                    st.markdown(f"**{seat_name}**: {msg['content']}")
            
            # New message
            user_msg = st.text_input("Your message:", key=f"input_{seat_name}")
            
            col1, col2 = st.columns(2)
            with col1:
                if st.button("Send", key=f"send_{seat_name}"):
                    if user_msg.strip():
                        # Add to history
                        st.session_state[f"conv_history_{seat_name}"].append({
                            "role": "human",
                            "content": user_msg
                        })
                        # Get response from engine
                        response = st.session_state.engine.converse_with_agent(
                            seat_name.lower().replace(" ", "_"),
                            user_msg
                        )
                        st.session_state[f"conv_history_{seat_name}"].append({
                            "role": "agent",
                            "content": response
                        })
                        st.rerun()
            
            with col2:
                if st.button("Close", key=f"close_{seat_name}"):
                    st.session_state[f"modal_{seat_name}"] = False
                    st.rerun()

if __name__ == "__main__":
    main()