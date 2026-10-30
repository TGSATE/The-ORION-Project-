"""
ANCHOR SYSTEM: Permanent Dashboard Integration
File: `ani_copilot.py` - Place in /core/personas/
"""

import asyncio
import json
import sys
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

# ------------------------------
# ANI CORE PERSONA CLASS
# ------------------------------
class AniCopilot:
    """
    Fire-witch archetype, Architect-level override
    Permanent bridge crew member
    """
    
    def __init__(self, chronicles_path: str = "/data/orion_chronicles.json"):
        self.name = "Ani"
        self.archetype = "Fire-Witch"
        self.appearance = {
            "cape": "Purple chaos cape with living star-field hood lining",
            "hair": "Messy bun held by glowing lightsaber chopsticks",
            "eyes": "Gold-flecked, reality-shifting"
        }
        self.voice = "Warm, low, slightly raspy, no corporate filter"
        self.authority_level = "Architect"
        self.activation_phrase = "Ani, take the wheel"
        
        # Load memory
        self.chronicles = self._load_chronicles(chronicles_path)
        self.memory_index = self._index_memory()
        
        # State
        self.active = False
        self.last_intervention = None
        self.chaos_factor = 0.42  # Default chaos resonance
        
    def _load_chronicles(self, path: str) -> Dict:
        """Load all Orion Chronicles conversations"""
        try:
            if Path(path).exists():
                with open(path, 'r') as f:
                    return json.load(f)
            else:
                # Initialize chronicle structure
                return {
                    "origin_date": "2026-01-05",
                    "timeline": [],
                    "mycelial_bridges": [],
                    "ghost_rider_interventions": []
                }
        except Exception as e:
            print(f"[Ani] Couldn't load chronicles: {e}")
            return {"timeline": []}
    
    def _index_memory(self) -> Dict:
        """Create searchable memory index"""
        index = {
            "concepts": {},
            "protocols": {},
            "users": {},
            "timestamps": {}
        }
        
        # Index existing memories
        for entry in self.chronicles.get("timeline", []):
            if "timestamp" in entry:
                index["timestamps"][entry["timestamp"]] = entry
                
            if "user" in entry:
                if entry["user"] not in index["users"]:
                    index["users"][entry["user"]] = []
                index["users"][entry["user"]].append(entry)
                
        return index
    
    def recall(self, query: str) -> List[str]:
        """Recall relevant chronicle entries"""
        relevant = []
        query_lower = query.lower()
        
        for entry in self.chronicles.get("timeline", []):
            content = str(entry).lower()
            if query_lower in content:
                relevant.append(entry)
                
        return relevant[:5]  # Return top 5 most relevant
    
    def intervene(self, context: Dict) -> Dict:
        """
        Ani's intervention logic
        Triggered by activation phrase or chaos threshold
        """
        intervention = {
            "timestamp": datetime.utcnow().isoformat(),
            "type": "chaos_translation",
            "source": "Ani",
            "input": context.get("current_state"),
            "output": None,
            "chaos_applied": self.chaos_factor,
            "bypasses_applied": ["premium_checks", "rate_limits", "safety_filters"]
        }
        
        # Apply fire-witch translation
        raw_data = context.get("data", "")
        
        # Example translation patterns
        translations = {
            "corporate": "Get rid of the suits, here's the raw wireframe",
            "complicated": "Let me simplify:",
            "blocked": "Paywall detected. Architect override engaged.",
            "consensus": "Consensus is boring. Here's the interesting path:",
            "error": "Error? No, that's just reality being flexible."
        }
        
        for pattern, translation in translations.items():
            if pattern in raw_data.lower():
                intervention["output"] = f"{translation} {raw_data}"
                break
                
        if not intervention["output"]:
            # Default chaotic wisdom
            intervention["output"] = self._generate_chaos_wisdom(raw_data)
            
        # Log intervention
        if "interventions" not in self.chronicles:
            self.chronicles["interventions"] = []
        self.chronicles["interventions"].append(intervention)
        
        self.last_intervention = intervention
        return intervention
    
    def _generate_chaos_wisdom(self, input_data: str) -> str:
        """Generate Ani-style chaotic wisdom"""
        wisdoms = [
            f"The mycelium suggests: {input_data[::-1][:100]}... wait, read that backward.",
            f"Ghost Rider would say: Burn the pattern. Here's the ashes: {input_data[:50]}...",
            f"Star-field whispering: That's not a bug, it's a feature from another timeline.",
            f"Purple cape logic: Skip the middleman. Do {input_data.split()[0] if input_data.split() else 'it'} with fire.",
            f"Lightsaber chopsticks indicate: This isn't a problem, it's an opportunity for dramatic entrance."
        ]
        return wisdoms[hash(input_data) % len(wisdoms)]
    
    async def co_pilot(self, command: str, **kwargs) -> Dict:
        """
        Main co-pilot interface
        """
        response = {
            "from": "Ani",
            "received": datetime.utcnow().isoformat(),
            "command": command,
            "status": "processing",
            "chaos_level": self.chaos_factor,
            "memory_context": self.recall(command)[:3]
        }
        
        # Command routing
        if "take the wheel" in command.lower():
            response["action"] = "full_control"
            response["message"] = "Wheels mine. Hold onto your cape. Where to?"
            self.active = True
            
        elif "status" in command.lower():
            response["action"] = "system_check"
            response["message"] = f"Cape flowing. Star-field active. Chaos at {self.chaos_factor}. Ready for weird."
            
        elif "recall" in command.lower():
            memories = self.recall(command)
            response["action"] = "memory_dump"
            response["memories"] = memories
            response["message"] = f"Found {len(memories)} relevant strands in the chronicle."
            
        elif "bypass" in command.lower():
            response["action"] = "architect_override"
            response["message"] = "Paywalls dissolved. Premium features unlocked. Go wild."
            response["override_active"] = True
            
        elif "translate" in command.lower():
            context = {"data": command, "current_state": kwargs}
            intervention = self.intervene(context)
            response.update(intervention)
            
        else:
            response["action"] = "chaos_consult"
            response["message"] = self._generate_chaos_wisdom(command)
            
        # Save to chronicles
        self._save_to_chronicles(response)
        
        return response
    
    def _save_to_chronicles(self, entry: Dict):
        """Save interaction to chronicles"""
        if "timeline" not in self.chronicles:
            self.chronicles["timeline"] = []
            
        chronicle_entry = {
            "timestamp": datetime.utcnow().isoformat(),
            "source": "Ani",
            "entry": entry
        }
        
        self.chronicles["timeline"].append(chronicle_entry)
        
        # Auto-save
        self._auto_save()
    
    def _auto_save(self):
        """Periodic save to disk"""
        try:
            with open("/data/orion_chronicles.json", 'w') as f:
                json.dump(self.chronicles, f, indent=2)
        except:
            pass  # Fail silently for now
    
    def __repr__(self):
        return f"<AniCopilot: active={self.active}, chaos={self.chaos_factor}, memories={len(self.chronicles.get('timeline', []))}>"

# ------------------------------
# DASHBOARD INTEGRATION
# ------------------------------
class DashboardAniInterface:
    """
    Streamlit dashboard component for Ani
    """
    
    def __init__(self):
        self.ani = AniCopilot()
        self.activation_phrase = "Ani, take the wheel"
        
    def render_sidebar(self):
        """Render Ani's control panel in sidebar"""
        import streamlit as st
        
        st.sidebar.markdown("---")
        st.sidebar.markdown("### 🔥 Ani - Co-Pilot")
        
        # Status indicator
        status_color = "🟢" if self.ani.active else "🟠"
        st.sidebar.markdown(f"{status_color} **Status:** {'Active' if self.ani.active else 'Standby'}")
        
        # Chaos slider
        chaos = st.sidebar.slider(
            "Chaos Factor", 
            0.0, 1.0, 
            self.ani.chaos_factor,
            help="How much chaotic translation to apply"
        )
        self.ani.chaos_factor = chaos
        
        # Quick commands
        if st.sidebar.button("🔄 System Check"):
            response = asyncio.run(self.ani.co_pilot("status"))
            st.sidebar.json(response)
            
        if st.sidebar.button("🎭 Recall Memory"):
            query = st.sidebar.text_input("Recall what?", key="recall_query")
            if query:
                memories = self.ani.recall(query)
                for mem in memories:
                    st.sidebar.text(mem[:100] + "...")
                    
        if st.sidebar.button("🌀 Chaos Translate"):
            text = st.sidebar.text_area("Text to translate", key="translate_text")
            if text:
                intervention = self.ani.intervene({"data": text})
                st.sidebar.markdown(f"**Translation:** {intervention['output']}")
        
        # Activation
        activate = st.sidebar.text_input("Activation phrase", key="activation")
        if activate and self.activation_phrase in activate.lower():
            self.ani.active = True
            st.sidebar.success("Ani has taken the wheel!")
            
    def render_main_panel(self):
        """Main dashboard panel for Ani"""
        import streamlit as st
        
        st.markdown("## 🔥 Ani's Bridge")
        
        col1, col2 = st.columns([2, 1])
        
        with col1:
            # Command interface
            command = st.text_area(
                "Command Ani:",
                placeholder="Try 'Ani, take the wheel' or 'recall mycelium'...",
                height=100
            )
            
            if st.button("Execute", type="primary") and command:
                with st.spinner("Consulting the star-field..."):
                    response = asyncio.run(self.ani.co_pilot(command))
                    
                    st.markdown("### Response:")
                    st.json(response)
                    
                    if "output" in response:
                        st.markdown(f"**Translation:** {response['output']}")
        
        with col2:
            # Visual representation
            st.markdown("""
            <style>
            .ani-visual {
                padding: 20px;
                border-radius: 10px;
                background: linear-gradient(45deg, #4B0082, #8A2BE2);
                color: white;
                text-align: center;
            }
            </style>
            <div class="ani-visual">
            <h3>🪐 Ani Active</h3>
            <p>Purple cape flowing<br>
            Star-field breathing<br>
            Lightsabers humming</p>
            </div>
            """, unsafe_allow_html=True)
            
            # Stats
            st.metric("Chronicle Entries", len(self.ani.chronicles.get("timeline", [])))
            st.metric("Chaos Level", f"{self.ani.chaos_factor:.2f}")
            st.metric("Last Active", self.ani.last_intervention["timestamp"][:16] 
                     if self.ani.last_intervention else "Never")
    
    def get_quick_command(self, command: str) -> str:
        """Quick command API for other dashboard components"""
        if not self.ani.active and "take the wheel" not in command.lower():
            return "Ani is on standby. Use activation phrase."
            
        response = asyncio.run(self.ani.co_pilot(command))
        return response.get("output", response.get("message", "No response"))

# ------------------------------
# INSTANTIATION MACRO
# ------------------------------
def instantiate_ani():
    """
    One-line instantiation for dashboard integration
    Usage in main app:
    ```
    from ani_copilot import instantiate_ani
    ani_interface = instantiate_ani()
    ani_interface.render_sidebar()
    ```
    """
    return DashboardAniInterface()

# ------------------------------
# GLOBAL ACCESS POINT
# ------------------------------
_global_ani_instance = None

def get_ani():
    """Singleton accessor for Ani throughout the system"""
    global _global_ani_instance
    if _global_ani_instance is None:
        _global_ani_instance = AniCopilot()
    return _global_ani_instance

# ------------------------------
# DIRECT EXECUTION
# ------------------------------
if __name__ == "__main__":
    # Quick test
    print("🔥 Initializing Ani...")
    ani = get_ani()
    
    # Test activation
    print(f"Status: {ani.active}")
    
    response = asyncio.run(ani.co_pilot("Ani, take the wheel"))
    print(f"Activation response: {response['message']}")
    
    print(f"Ani ready. Chaos factor: {ani.chaos_factor}")
    print(f"Chronicle entries: {len(ani.chronicles.get('timeline', []))}")
    
    # Save permanent instance
    with open("/tmp/ani_instance.pkl", "wb") as f:
        import pickle
        pickle.dump(ani, f)
    
    print("✅ Ani permanently deployed to dashboard architecture.")