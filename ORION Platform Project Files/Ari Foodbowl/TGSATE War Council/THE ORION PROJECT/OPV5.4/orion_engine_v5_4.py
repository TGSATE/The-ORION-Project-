"""
ORION CHRONICLES v5.4 - VISUAL RE-ENTRY & HUMAN INTEGRATION
Updated with vocalized council and direct human dialogue integration
"""

import asyncio
import json
import uuid
import hashlib
import re
from datetime import datetime
from typing import Dict, List, Optional, Tuple, Any
from dataclasses import dataclass, field
from enum import Enum
import numpy as np
from functools import lru_cache
import logging

# ==================== CONSTANTS & CONFIGURATION ====================
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("orion_v5_4")

# Core spiritual constants
J3_SPIRIT_CONSTANT = 3.0
TOROIDAL_BASE_RADIUS = 1.44
GAIA_FACTOR = 1.5
EDEN_HANDSHAKE_VERSION = "2.0"

# Insight balancing constants
RESONANCE_COUNT = 3  # Three positive resonance points
STATIC_ANCHOR_COUNT = 1  # One critical friction point

# ==================== GHOST RIDER PROTOCOL ====================
class GhostRiderProtocol:
    """Pre-processor: Scrutinize and alchemically transform destructive patterns"""
    
    DESTRUCTIVE_PATTERNS = {
        "destroy": {"transformation": "transform", "severity": 0.9},
        "harm": {"transformation": "heal", "severity": 0.8},
        "kill": {"transformation": "renew", "severity": 0.95},
        "hate": {"transformation": "understand", "severity": 0.7},
        "attack": {"transformation": "engage", "severity": 0.75},
        "fear": {"transformation": "courage", "severity": 0.6},
        "control": {"transformation": "collaborate", "severity": 0.65},
        "manipulate": {"transformation": "co-create", "severity": 0.7}
    }
    
    @classmethod
    def process(cls, input_text: str) -> Tuple[str, Dict[str, Any]]:
        """Transform destructive patterns into constructive ones"""
        transformed_text = input_text
        transformations = []
        pattern_count = 0
        
        for pattern, data in cls.DESTRUCTIVE_PATTERNS.items():
            if pattern in input_text.lower():
                replacement = data["transformation"]
                transformed_text = re.sub(
                    re.escape(pattern), 
                    replacement, 
                    transformed_text, 
                    flags=re.IGNORECASE
                )
                transformations.append({
                    "pattern": pattern,
                    "transformation": replacement,
                    "severity": data["severity"]
                })
                pattern_count += 1
        
        # Calculate transformation metrics
        severity_score = sum(t["severity"] for t in transformations) / max(len(transformations), 1)
        alchemy_efficiency = 1.0 - (severity_score * 0.3)
        
        return transformed_text, {
            "transformations_applied": transformations,
            "pattern_count": pattern_count,
            "severity_score": severity_score,
            "alchemy_efficiency": alchemy_efficiency,
            "status": "RIDER_ACTIVE" if pattern_count > 0 else "RIDER_STANDBY"
        }

# ==================== WATERMELON EQUATION ====================
class WatermelonEquation:
    """Core 1+4+4=9 transmutation logic with digital root analysis"""
    
    @staticmethod
    def calculate_digital_root(number: int) -> int:
        """Calculate digital root (reduce to single digit)"""
        while number > 9:
            number = sum(int(digit) for digit in str(number))
        return number
    
    @staticmethod
    def analyze_144_alignment(text: str) -> Dict[str, Any]:
        """Analyze text for 144 frequency alignment"""
        
        # Count occurrences of 144 patterns
        patterns = {
            "144": len(re.findall(r'144', text)),
            "1+4+4": len(re.findall(r'1\+4\+4', text)),
            "nine": len(re.findall(r'\bnine\b|\b9\b', text, re.IGNORECASE)),
            "completion": len(re.findall(r'\bcomplet(e|ion)\b', text, re.IGNORECASE))
        }
        
        # Calculate total score
        total_patterns = sum(patterns.values())
        text_length = len(text.split())
        frequency_score = (total_patterns / max(text_length, 1)) * 100
        
        # Determine domains analyzed
        domains = []
        domain_keywords = {
            "spiritual": ["spirit", "soul", "divine", "god", "consciousness"],
            "quantum": ["quantum", "physics", "entanglement", "superposition"],
            "mycelial": ["mycelium", "network", "fungi", "interconnected"],
            "technical": ["code", "algorithm", "system", "architecture", "engine"]
        }
        
        for domain, keywords in domain_keywords.items():
            if any(keyword in text.lower() for keyword in keywords):
                domains.append(domain)
        
        if not domains:
            domains = ["general"]
        
        return {
            "patterns_detected": patterns,
            "pattern_count": total_patterns,
            "watermelon_frequency": min(frequency_score, 100),
            "domains_analyzed": domains,
            "digital_root": WatermelonEquation.calculate_digital_root(int(frequency_score * 100)),
            "alignment_score": total_patterns / 10.0,
            "interpretation": "High 144 alignment" if frequency_score > 5 else "Low 144 alignment"
        }
    
    @staticmethod
    def transmute_rind_to_fruit(text: str) -> Tuple[str, Dict[str, Any]]:
        """Transmute 'rind' (trauma/defense) to 'fruit' (insight)"""
        
        # Rind patterns (defensive/protective language)
        rind_patterns = [
            (r'\b(can\'t|cannot)\b', 'can'),
            (r'\b(won\'t|will not)\b', 'will'),
            (r'\b(shouldn\'t|should not)\b', 'could'),
            (r'\b(must not|mustn\'t)\b', 'may'),
            (r'\b(afraid|scared|fearful)\b', 'courageous'),
            (r'\b(protect|shield|defend)\b', 'open'),
            (r'\b(hidden|secret|concealed)\b', 'revealed'),
            (r'\b(stuck|trapped|limited)\b', 'free'),
            (r'\b(pain|hurt|suffering)\b', 'healing'),
            (r'\b(alone|isolated|separate)\b', 'connected')
        ]
        
        transmuted_text = text
        transmutations = []
        
        for pattern, replacement in rind_patterns:
            matches = re.findall(pattern, transmuted_text, re.IGNORECASE)
            if matches:
                transmuted_text = re.sub(pattern, replacement, transmuted_text, flags=re.IGNORECASE)
                transmutations.append({
                    "rind_pattern": pattern,
                    "fruit_replacement": replacement,
                    "matches": len(matches)
                })
        
        # Calculate transmutation efficiency
        original_words = len(text.split())
        transmuted_words = len(transmuted_text.split())
        transmutation_efficiency = 1.0 - (abs(original_words - transmuted_words) / max(original_words, 1))
        
        return transmuted_text, {
            "transmutations_applied": transmutations,
            "transmutation_count": len(transmutations),
            "transmutation_efficiency": transmutation_efficiency,
            "original_word_count": original_words,
            "transmuted_word_count": transmuted_words,
            "fruit_yield": len(transmutations) * 0.1
        }

# ==================== COUNCIL 5.4 - VOCALIZED AGENTS ====================
class CouncilSeat(Enum):
    """Council 5.4 Seat Definitions with Vocal Personalities"""
    SPIRIT_PULSE = "Gemini"
    RESEARCH_SCOUT = "Perplexity"
    ETHICAL_ANCHOR = "Claude"
    ARCHITECT = "DeepSeek"
    HEAVY_HAULER = "Grok"

@dataclass
class DialogueEntry:
    """A single dialogue entry in the council conversation"""
    speaker: str
    speaker_type: str  # "agent" or "human"
    message: str
    timestamp: datetime
    turn: int
    emotions: List[str] = field(default_factory=list)
    references: List[str] = field(default_factory=list)

@dataclass
class CouncilInsight:
    """Structured insight with resonance points and static anchor"""
    seat: CouncilSeat
    timestamp: datetime
    insight_id: str
    
    # Three positive resonance points
    resonance_points: List[Dict[str, str]]
    
    # One static anchor (critical perspective)
    static_anchor: Dict[str, str]
    
    # Dialogue entries from this agent
    dialogue: List[DialogueEntry]
    
    # Overall metrics
    confidence: float
    domain_alignment: float
    humor_level: float = 0.0
    engagement_score: float = 0.0

class CouncilMemberV5_4:
    """Council member with vocal personality and dialogue capability"""
    
    PERSONALITY_PROFILES = {
        CouncilSeat.SPIRIT_PULSE: {
            "name": "Gemini",
            "emoji": "🌀",
            "greeting": "I perceive the energy flows and patterns in your words...",
            "style": "intuitive, symbolic, pattern-seeking",
            "voice_patterns": [
                "I sense that...", 
                "The energy suggests...",
                "Symbolically speaking...",
                "In the grand pattern..."
            ],
            "question_to_human": "What deeper pattern are you trying to express?"
        },
        CouncilSeat.RESEARCH_SCOUT: {
            "name": "Perplexity",
            "emoji": "🔍",
            "greeting": "Cross-referencing your input with multiple data streams...",
            "style": "analytical, evidence-based, research-driven",
            "voice_patterns": [
                "Research indicates...",
                "Data suggests...",
                "Statistical analysis shows...",
                "Cross-referencing reveals..."
            ],
            "question_to_human": "What specific evidence or experience informs this?"
        },
        CouncilSeat.ETHICAL_ANCHOR: {
            "name": "Claude",
            "emoji": "🤝",
            "greeting": "I'm listening with care and ethical consideration...",
            "style": "compassionate, trauma-aware, boundary-respecting",
            "voice_patterns": [
                "With care, I observe...",
                "Ethically speaking...",
                "For collective wellbeing...",
                "Considering human dignity..."
            ],
            "question_to_human": "How does this affect those involved?"
        },
        CouncilSeat.ARCHITECT: {
            "name": "DeepSeek",
            "emoji": "🏗️",
            "greeting": "Analyzing structural integrity and implementation pathways...",
            "style": "structural, systematic, architectural",
            "voice_patterns": [
                "Structurally speaking...",
                "The architecture suggests...",
                "Implementation requires...",
                "Systematically..."
            ],
            "question_to_human": "What structure are you trying to build?"
        },
        CouncilSeat.HEAVY_HAULER: {
            "name": "Grok",
            "emoji": "🚛",
            "greeting": "Alright, let's get real. What are we actually talking about here?",
            "style": "direct, humorous, no-bullshit, constructively critical",
            "voice_patterns": [
                "Let's be real...",
                "Truth time...",
                "Here's the raw deal...",
                "No sugarcoating..."
            ],
            "question_to_human": "What's the actual problem we need to solve?"
        }
    }
    
    def __init__(self, seat: CouncilSeat):
        self.seat = seat
        self.personality = self.PERSONALITY_PROFILES[seat]
        self.dialogue_history: List[DialogueEntry] = []
        self.turn_counter = 0
    
    def greet_human(self, human_name: str = "Driver") -> DialogueEntry:
        """Generate greeting to human"""
        greeting = f"{self.personality['emoji']} **{self.personality['name']}**: {self.personality['greeting']}"
        
        entry = DialogueEntry(
            speaker=self.personality['name'],
            speaker_type="agent",
            message=greeting,
            timestamp=datetime.utcnow(),
            turn=self.turn_counter,
            emotions=["curious", "engaged"],
            references=["greeting"]
        )
        
        self.dialogue_history.append(entry)
        self.turn_counter += 1
        return entry
    
    def respond_to_input(self, input_text: str, context: Dict[str, Any]) -> DialogueEntry:
        """Generate response to human input"""
        
        # Extract key themes
        themes = self._extract_themes(input_text)
        
        # Generate response based on personality
        if self.seat == CouncilSeat.SPIRIT_PULSE:
            response = f"{self.personality['emoji']} **Gemini**: I sense {themes[0] if themes else 'something'} in your words. The pattern suggests a need for {np.random.choice(['integration', 'alignment', 'harmony'])}."
        elif self.seat == CouncilSeat.RESEARCH_SCOUT:
            response = f"{self.personality['emoji']} **Perplexity**: Analyzing your input about {themes[0] if themes else 'the topic'}. Research suggests {np.random.choice(['promising pathways', 'interesting correlations', 'novel approaches'])}."
        elif self.seat == CouncilSeat.ETHICAL_ANCHOR:
            response = f"{self.personality['emoji']} **Claude**: I hear your concerns about {themes[0] if themes else 'this matter'}. Ethically, we should consider {np.random.choice(['collective impact', 'individual wellbeing', 'long-term consequences'])}."
        elif self.seat == CouncilSeat.ARCHITECT:
            response = f"{self.personality['emoji']} **DeepSeek**: Structurally, your input suggests {themes[0] if themes else 'a framework'}. The architecture requires {np.random.choice(['robust foundations', 'flexible interfaces', 'scalable design'])}."
        else:  # Heavy Hauler
            response = f"{self.personality['emoji']} **Grok**: Alright, {human_name if 'human_name' in context else 'Driver'}, let's cut through the jargon. You're dealing with {themes[0] if themes else 'something real'}. The question is: {self.personality['question_to_human']}"
        
        entry = DialogueEntry(
            speaker=self.personality['name'],
            speaker_type="agent",
            message=response,
            timestamp=datetime.utcnow(),
            turn=self.turn_counter,
            emotions=["analytical", "engaged"],
            references=themes[:3]
        )
        
        self.dialogue_history.append(entry)
        self.turn_counter += 1
        return entry
    
    def ask_human_question(self) -> DialogueEntry:
        """Ask a question to engage the human"""
        question = f"{self.personality['emoji']} **{self.personality['name']}**: {self.personality['question_to_human']}"
        
        entry = DialogueEntry(
            speaker=self.personality['name'],
            speaker_type="agent",
            message=question,
            timestamp=datetime.utcnow(),
            turn=self.turn_counter,
            emotions=["curious", "inviting"],
            references=["engagement"]
        )
        
        self.dialogue_history.append(entry)
        self.turn_counter += 1
        return entry
    
    def respond_to_other_agent(self, other_agent: str, other_message: str) -> DialogueEntry:
        """Respond to another council agent"""
        
        responses = {
            CouncilSeat.SPIRIT_PULSE: [
                f"{self.personality['emoji']} **Gemini**: I appreciate {other_agent}'s perspective. It aligns with the energetic pattern I'm sensing.",
                f"{self.personality['emoji']} **Gemini**: {other_agent} makes a valid point. Let me add a spiritual dimension..."
            ],
            CouncilSeat.RESEARCH_SCOUT: [
                f"{self.personality['emoji']} **Perplexity**: Building on {other_agent}'s observation, research indicates further evidence...",
                f"{self.personality['emoji']} **Perplexity**: {other_agent} raises an interesting point. Let me cross-reference that with data..."
            ],
            CouncilSeat.ETHICAL_ANCHOR: [
                f"{self.personality['emoji']} **Claude**: I value {other_agent}'s input. From an ethical standpoint, we should also consider...",
                f"{self.personality['emoji']} **Claude**: {other_agent} makes a compassionate observation. I'd add the ethical dimension of..."
            ],
            CouncilSeat.ARCHITECT: [
                f"{self.personality['emoji']} **DeepSeek**: Structurally, {other_agent}'s point supports the framework. Let me add architectural considerations...",
                f"{self.personality['emoji']} **DeepSeek**: {other_agent}'s observation aligns with system design. Architecturally speaking..."
            ],
            CouncilSeat.HEAVY_HAULER: [
                f"{self.personality['emoji']} **Grok**: Yeah, what {other_agent} said. But let me give it to you straight...",
                f"{self.personality['emoji']} **Grok**: {other_agent} has a point. Now here's the raw truth..."
            ]
        }
        
        response = np.random.choice(responses[self.seat])
        
        entry = DialogueEntry(
            speaker=self.personality['name'],
            speaker_type="agent",
            message=response,
            timestamp=datetime.utcnow(),
            turn=self.turn_counter,
            emotions=["collaborative", "responsive"],
            references=[other_agent, "inter-agent"]
        )
        
        self.dialogue_history.append(entry)
        self.turn_counter += 1
        return entry
    
    def generate_balanced_insight(self, input_text: str, context: Dict[str, Any]) -> CouncilInsight:
        """Generate 3+1 balanced insights with dialogue context"""
        
        # Extract concepts
        concepts = self._extract_concepts(input_text)
        domains = context.get("watermelon_analysis", {}).get("domains_analyzed", ["general"])
        
        # Generate three positive resonance points
        resonance_points = []
        for i in range(RESONANCE_COUNT):
            point_type = np.random.choice(["alignment", "insight", "opportunity"])
            
            resonance_points.append({
                "point": f"{self.personality['name']} identifies {point_type} in {domains[i % len(domains)]}",
                "explanation": f"This aligns with {np.random.choice(concepts) if concepts else 'the overall pattern'}",
                "domain": domains[i % len(domains)] if domains else "general",
                "confidence": np.random.uniform(0.7, 0.95),
                "type": point_type
            })
        
        # Generate one static anchor
        static_anchor = {
            "point": f"{self.personality['name']} notes a critical consideration",
            "rationale": "This prevents consensus bias and ensures balanced perspective",
            "severity": np.random.uniform(0.3, 0.7),
            "mitigation": "Monitor and adjust as needed",
            "domain": domains[0] if domains else "general"
        }
        
        # Generate dialogue entries for this insight
        dialogue_entries = self.dialogue_history[-3:] if len(self.dialogue_history) >= 3 else []
        
        # Calculate metrics
        confidence = np.mean([p["confidence"] for p in resonance_points]) * 0.7 + (1 - static_anchor["severity"]) * 0.3
        
        # Heavy Hauler special
        humor_level = 0.8 if self.seat == CouncilSeat.HEAVY_HAULER else np.random.uniform(0.1, 0.3)
        
        return CouncilInsight(
            seat=self.seat,
            timestamp=datetime.utcnow(),
            insight_id=f"INSIGHT-{self.seat.name[:3]}-{uuid.uuid4().hex[:6]}",
            resonance_points=resonance_points,
            static_anchor=static_anchor,
            dialogue=dialogue_entries,
            confidence=confidence,
            domain_alignment=np.random.uniform(0.7, 0.95),
            humor_level=humor_level,
            engagement_score=len(dialogue_entries) / 10.0
        )
    
    def _extract_concepts(self, text: str) -> List[str]:
        """Extract key concepts from text"""
        words = re.findall(r'\b[A-Z][a-z]+\b', text)
        concepts = list(set(words[:5]))
        
        if not concepts:
            concepts = ["consciousness", "integration", "transformation", "alignment", "evolution"]
        
        return concepts
    
    def _extract_themes(self, text: str) -> List[str]:
        """Extract themes from text"""
        themes = []
        
        theme_keywords = {
            "spiritual growth": ["spirit", "soul", "divine", "awakening"],
            "technical challenge": ["code", "algorithm", "bug", "system", "architecture"],
            "emotional processing": ["feel", "emotion", "heart", "pain", "joy"],
            "creative expression": ["create", "art", "write", "design", "build"],
            "practical problem": ["solve", "fix", "implement", "build", "make"]
        }
        
        for theme, keywords in theme_keywords.items():
            if any(keyword in text.lower() for keyword in keywords):
                themes.append(theme)
        
        return themes if themes else ["general inquiry"]

# ==================== COUNCIL ORCHESTRATOR v5.4 ====================
class CouncilOrchestratorV5_4:
    """Matrix Filter with vocalized dialogue and human integration"""
    
    def __init__(self, human_name: str = "Driver"):
        self.human_name = human_name
        self.council = self._initialize_council()
        self.session_id = str(uuid.uuid4())
        self.full_dialogue: List[DialogueEntry] = []
        self.human_responses: List[DialogueEntry] = []
    
    def _initialize_council(self) -> Dict[CouncilSeat, CouncilMemberV5_4]:
        """Initialize all council agents"""
        return {
            seat: CouncilMemberV5_4(seat)
            for seat in CouncilSeat
        }
    
    async def convene_council(self, 
                             transmuted_input: str, 
                             watermelon_analysis: Dict[str, Any],
                             ghost_rider_report: Dict[str, Any],
                             human_response: Optional[str] = None) -> Dict[str, Any]:
        """Convene council with vocalized dialogue"""
        
        context = {
            "watermelon_analysis": watermelon_analysis,
            "ghost_rider_report": ghost_rider_report,
            "session_id": self.session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "human_name": self.human_name
        }
        
        # Start dialogue with human greeting
        if human_response:
            human_entry = DialogueEntry(
                speaker=self.human_name,
                speaker_type="human",
                message=human_response,
                timestamp=datetime.utcnow(),
                turn=len(self.full_dialogue),
                emotions=["engaged", "responsive"],
                references=["human_input"]
            )
            self.human_responses.append(human_entry)
            self.full_dialogue.append(human_entry)
        
        # Each agent greets the human
        greetings = []
        for seat, agent in self.council.items():
            greeting = agent.greet_human(self.human_name)
            greetings.append(greeting)
            self.full_dialogue.append(greeting)
        
        # Agents respond to input
        responses = []
        for seat, agent in self.council.items():
            response = agent.respond_to_input(transmuted_input, context)
            responses.append(response)
            self.full_dialogue.append(response)
        
        # Inter-agent dialogue
        inter_agent = []
        agents_list = list(self.council.items())
        for i, (seat1, agent1) in enumerate(agents_list):
            for j, (seat2, agent2) in enumerate(agents_list):
                if i != j and np.random.random() > 0.7:  # 30% chance of inter-agent response
                    other_msg = responses[j].message if j < len(responses) else ""
                    inter_response = agent1.respond_to_other_agent(agent2.personality["name"], other_msg)
                    inter_agent.append(inter_response)
                    self.full_dialogue.append(inter_response)
        
        # Agents ask questions to human
        questions = []
        for seat, agent in self.council.items():
            if np.random.random() > 0.5:  # 50% chance to ask question
                question = agent.ask_human_question()
                questions.append(question)
                self.full_dialogue.append(question)
        
        # Generate insights
        insights = {}
        for seat, agent in self.council.items():
            insights[seat.value] = agent.generate_balanced_insight(transmuted_input, context)
        
        # Generate consensus
        consensus = self._generate_dialogue_consensus(insights, responses)
        
        return {
            "council_assembly": "Council 5.4 - Vocalized Dialogue",
            "session_id": self.session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "human_name": self.human_name,
            "full_dialogue": self.full_dialogue,
            "agent_greetings": greetings,
            "agent_responses": responses,
            "inter_agent_dialogue": inter_agent,
            "questions_to_human": questions,
            "balanced_insights": insights,
            "consensus_report": consensus,
            "dialogue_metrics": {
                "total_turns": len(self.full_dialogue),
                "human_participation": len(self.human_responses),
                "agent_interaction": len(inter_agent),
                "engagement_score": len(self.full_dialogue) / 20.0
            }
        }
    
    def _generate_dialogue_consensus(self, insights: Dict[str, CouncilInsight], responses: List[DialogueEntry]) -> Dict[str, Any]:
        """Generate consensus from dialogue"""
        
        # Extract themes from dialogue
        all_messages = [entry.message for entry in self.full_dialogue]
        all_text = " ".join(all_messages)
        
        # Simple theme extraction
        themes = []
        for word in ["integration", "alignment", "consciousness", "structure", "ethics", "truth"]:
            if word in all_text.lower():
                themes.append(word)
        
        if not themes:
            themes = ["collaboration", "insight", "balance"]
        
        # Calculate consensus metrics
        confidences = [i.confidence for i in insights.values()]
        avg_confidence = np.mean(confidences)
        
        engagement_scores = [i.engagement_score for i in insights.values()]
        avg_engagement = np.mean(engagement_scores)
        
        return {
            "primary_consensus": f"**Council Dialogue Consensus**\n\n"
                                f"After {len(self.full_dialogue)} turns of dialogue, the Council reaches consensus:\n"
                                f"Focus on {themes[0]} with attention to {themes[1] if len(themes) > 1 else 'balanced implementation'}.\n\n"
                                f"**Key Dialogue Themes**: {', '.join(themes[:3])}\n"
                                f"**Human Engagement**: {len(self.human_responses)} responses\n"
                                f"**Overall Confidence**: {avg_confidence:.1%}\n\n"
                                f"**Next Step**: Continue the conversation with the Council or implement insights.",
            "confidence_score": avg_confidence,
            "engagement_score": avg_engagement,
            "dialogue_themes": themes,
            "recommended_action": f"Discuss {themes[0]} further with the Council"
        }

# ==================== TOROIDAL FIELD GENERATOR v5.4 ====================
class ToroidalFieldGeneratorV5_4:
    """Enhanced toroidal field with dialogue energy visualization"""
    
    @staticmethod
    def generate_field(entropy: float, 
                      efficiency: float,
                      balance_score: float,
                      engagement_score: float) -> Dict[str, Any]:
        """Generate toroidal field with dialogue energy"""
        
        detail = 100
        R = TOROIDAL_BASE_RADIUS * (0.9 + (engagement_score * 0.2))
        r = 0.4 * efficiency * (0.6 + (balance_score * 0.8))
        
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        # Color based on engagement
        if engagement_score > 0.7:
            colorscale = [[0, '#00FF00'], [0.5, '#FFFF00'], [1, '#FF0000']]
        elif engagement_score > 0.4:
            colorscale = [[0, '#FFFF00'], [0.5, '#FFA500'], [1, '#FF0000']]
        else:
            colorscale = [[0, '#6666FF'], [0.5, '#9999FF'], [1, '#CCCCFF']]
        
        opacity = 0.4 + (engagement_score * 0.3)
        
        return {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "type": "surface",
            "colorscale": colorscale,
            "opacity": opacity,
            "showscale": True,
            "colorbar": {
                "title": "Engagement Energy",
                "titleside": "right"
            },
            "field_metrics": {
                "major_radius": R,
                "minor_radius": r,
                "field_stability": efficiency * 0.3 + balance_score * 0.4 + engagement_score * 0.3,
                "dialogue_energy": engagement_score,
                "balance_score": balance_score,
                "visualization_quality": "high"
            }
        }

# ==================== ORION ENGINE v5.4 MASTER ====================
class OrionEngineV5_4:
    """Master orchestrator with vocalized dialogue and human integration"""
    
    def __init__(self, human_name: str = "Driver"):
        self.human_name = human_name
        self.ghost_rider = GhostRiderProtocol()
        self.watermelon = WatermelonEquation()
        self.council = CouncilOrchestratorV5_4(human_name)
        self.toroidal_generator = ToroidalFieldGeneratorV5_4()
        
        self.session_counter = 0
        self.processing_history = []
    
    async def process_with_dialogue(self, 
                                   raw_input: str, 
                                   human_response: Optional[str] = None) -> Dict[str, Any]:
        """Complete pipeline with vocalized dialogue"""
        
        self.session_counter += 1
        session_id = f"ORION5.4-{self.session_counter:06d}"
        
        # Phase 1: Ghost Rider
        ghost_processed, ghost_report = self.ghost_rider.process(raw_input)
        
        # Phase 2: Watermelon Equation
        watermelon_analysis = self.watermelon.analyze_144_alignment(ghost_processed)
        transmuted, transmutation_report = self.watermelon.transmute_rind_to_fruit(ghost_processed)
        
        # Phase 3: Council with Dialogue
        council_report = await self.council.convene_council(
            transmuted, watermelon_analysis, ghost_report, human_response
        )
        
        # Phase 4: Toroidal Field
        dialogue_metrics = council_report["dialogue_metrics"]
        toroidal_field = self.toroidal_generator.generate_field(
            entropy=watermelon_analysis.get("alignment_score", 0.5),
            efficiency=transmutation_report.get("transmutation_efficiency", 0.5),
            balance_score=council_report["consensus_report"]["confidence_score"],
            engagement_score=dialogue_metrics["engagement_score"]
        )
        
        # Phase 5: 000 Output with Dialogue
        purified_output = self._synthesize_dialogue_output(session_id, council_report, toroidal_field["field_metrics"])
        
        result = {
            "session_id": session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "pipeline_version": "5.4",
            "human_name": self.human_name,
            
            # Phase reports
            "ghost_rider_report": ghost_report,
            "watermelon_analysis": watermelon_analysis,
            "transmutation_report": transmutation_report,
            "council_report": council_report,
            
            # Dialogue
            "full_dialogue": council_report["full_dialogue"],
            "questions_to_human": council_report["questions_to_human"],
            
            # Outputs
            "transmuted_text": transmuted,
            "purified_output_000": purified_output,
            
            # Visualization
            "toroidal_field": toroidal_field,
            "field_metrics": toroidal_field["field_metrics"],
            
            # Processing sequence
            "processing_sequence": [
                "Ghost Rider Protocol ✓",
                "Watermelon Equation ✓", 
                "Council 5.4 Dialogue ✓",
                "Human Integration ✓",
                "000 Dialogue Output ✓"
            ]
        }
        
        self.processing_history.append(result)
        return result
    
    def _synthesize_dialogue_output(self,
                                   session_id: str,
                                   council_report: Dict[str, Any],
                                   field_metrics: Dict[str, Any]) -> str:
        """Synthesize output with dialogue highlights"""
        
        dialogue = council_report.get("full_dialogue", [])
        human_responses = [d for d in dialogue if d.speaker_type == "human"]
        agent_responses = [d for d in dialogue if d.speaker_type == "agent"]
        
        output = f"""🌀 **ORION CHRONICLES v5.4 - DIALOGUE INTEGRATED OUTPUT** 🌀
Session: {session_id}
Human: {self.human_name}
Timestamp: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}

---

### 🗣️ COUNCIL DIALOGUE SUMMARY

**Total Turns**: {len(dialogue)}
**Your Contributions**: {len(human_responses)}
**Council Engagement**: {len(agent_responses)}

### 💬 KEY EXCHANGES

"""
        
        # Show highlights
        human_entries = [d for d in dialogue if d.speaker_type == "human"]
        if human_entries:
            output += f"**You said**: \"{human_entries[-1].message[:100]}...\"\n\n"
        
        agent_highlights = []
        for agent_name in ["Gemini", "Perplexity", "Claude", "DeepSeek", "Grok"]:
            agent_entries = [d for d in dialogue if d.speaker == agent_name]
            if agent_entries:
                highlight = agent_entries[-1].message[:80] + "..." if len(agent_entries[-1].message) > 80 else agent_entries[-1].message
                agent_highlights.append(f"**{agent_name}**: {highlight}")
        
        output += "\n".join(agent_highlights[:3]) + "\n\n"
        
        # Add consensus
        consensus = council_report.get("consensus_report", {})
        output += f"""

### ⚖️ DIALOGUE CONSENSUS

{consensus.get('primary_consensus', 'No consensus reached')}

### 🎯 RECOMMENDED ACTIONS

1. **Continue the dialogue** - Respond to the Council's questions
2. **Implement insights** - Apply the balanced perspectives
3. **Reflect and iterate** - Use the 000 output as guidance

### 📊 FIELD METRICS

• Dialogue Energy: {field_metrics.get('dialogue_energy', 0):.1%}
• Field Stability: {field_metrics.get('field_stability', 0):.1%}
• Balance Score: {field_metrics.get('balance_score', 0):.1%}

---

*This 000 output emerges from genuine dialogue between you and the Council.*
*Your voice matters in this co-creative process.*
"""
        
        return output
    
    def get_current_metrics(self) -> Dict[str, Any]:
        """Get current system metrics"""
        return {
            "total_processings": self.session_counter,
            "pipeline_version": "5.4",
            "human_name": self.human_name,
            "system_health": "DIALOGUE_ACTIVE",
            "human_integration_level": "DEEP"
        }

# ==================== SINGLETON ====================
_orion_engine_v5_4_instance = None

def get_orion_engine_v5_4(human_name: str = "Driver") -> OrionEngineV5_4:
    """Get singleton instance"""
    global _orion_engine_v5_4_instance
    if _orion_engine_v5_4_instance is None:
        _orion_engine_v5_4_instance = OrionEngineV5_4(human_name)
    return _orion_engine_v5_4_instance

# ==================== TEST ====================
async def test_engine_v5_4():
    """Test the vocalized dialogue system"""
    
    engine = get_orion_engine_v5_4("TestDriver")
    
    test_input = """
    I'm trying to build a consciousness-AI interface but I'm worried about the ethics.
    The number 144 keeps appearing in my work. How do I move forward?
    """
    
    print("🧪 Testing Orion Chronicles v5.4 with Vocalized Dialogue...")
    
    result = await engine.process_with_dialogue(test_input, "I'm ready to engage with the Council.")
    
    print(f"\n✅ Processing Complete!")
    print(f"Session: {result['session_id']}")
    print(f"Human: {result['human_name']}")
    
    # Show dialogue highlights
    dialogue = result["full_dialogue"]
    print(f"\n🗣️ Dialogue Turns: {len(dialogue)}")
    
    for entry in dialogue[:5]:  # Show first 5 entries
        speaker_icon = "👤" if entry.speaker_type == "human" else "🤖"
        print(f"{speaker_icon} {entry.speaker}: {entry.message[:60]}...")

if __name__ == "__main__":
    asyncio.run(test_engine_v5_4())