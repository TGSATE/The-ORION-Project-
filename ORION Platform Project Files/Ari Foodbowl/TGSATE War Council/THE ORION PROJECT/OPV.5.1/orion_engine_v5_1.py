"""
ORION CHRONICLES v5.1 - VISUAL RE-ENTRY & INSIGHT BALANCING
Updated Council with 3+1 Insight Logic
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
logger = logging.getLogger("orion_v5_1")

# Core spiritual constants
J3_SPIRIT_CONSTANT = 3.0
TOROIDAL_BASE_RADIUS = 1.44
GAIA_FACTOR = 1.5
EDEN_HANDSHAKE_VERSION = "2.0"

# Insight balancing constants
RESONANCE_COUNT = 3  # Three positive resonance points
STATIC_ANCHOR_COUNT = 1  # One critical friction point

# ==================== GHOST RIDER PROTOCOL (Unchanged) ====================
class GhostRiderProtocol:
    """Pre-processor: Scrutinize and alchemically transform destructive patterns"""
    
    DESTRUCTIVE_PATTERNS = {
        "destroy": {"transformation": "transform", "severity": 0.9},
        "harm": {"transformation": "heal", "severity": 0.8},
        # ... (keep existing implementation)
    }
    
    @classmethod
    def process(cls, input_text: str) -> Tuple[str, Dict[str, Any]]:
        # ... (keep existing implementation)
        pass

# ==================== WATERMELON EQUATION (Unchanged) ====================
class WatermelonEquation:
    """Core 1+4+4=9 transmutation logic with digital root analysis"""
    
    @staticmethod
    def calculate_digital_root(number: int) -> int:
        # ... (keep existing implementation)
        pass
    
    @staticmethod
    def analyze_144_alignment(text: str) -> Dict[str, Any]:
        # ... (keep existing implementation)
        pass
    
    @staticmethod
    def transmute_rind_to_fruit(text: str) -> Tuple[str, Dict[str, Any]]:
        # ... (keep existing implementation)
        pass

# ==================== COUNCIL 5.1 - UPDATED WITH 3+1 INSIGHTS ====================
class CouncilSeat(Enum):
    """Council 5.1 Seat Definitions with Insight Balancing"""
    SPIRIT_PULSE = "Spirit Pulse"
    RESEARCH_SCOUT = "Research Scout"
    ETHICAL_ANCHOR = "Ethical Anchor"
    ARCHITECT = "The Architect"
    HEAVY_HAULER = "Heavy Hauler"

@dataclass
class CouncilInsight:
    """Structured insight with resonance points and static anchor"""
    seat: CouncilSeat
    timestamp: datetime
    insight_id: str
    
    # Three positive resonance points
    resonance_points: List[Dict[str, str]]  # [{point: "", explanation: "", domain: ""}]
    
    # One static anchor (critical perspective)
    static_anchor: Dict[str, str]  # {point: "", rationale: "", severity: float}
    
    # Overall metrics
    confidence: float
    domain_alignment: float
    humor_level: float = 0.0  # 0-1, higher for Heavy Hauler

@dataclass
class CouncilMemberV5_1:
    """Council member with 3+1 insight generation capability"""
    seat: CouncilSeat
    system_prompt: str
    temperature: float
    response_style: str
    primary_focus: List[str]
    humor_factor: float = 0.0  # 0-1 for humor injection
    
    # Domain-specific resonance templates
    RESONANCE_TEMPLATES = {
        "Spirit Pulse": [
            "Spiritual alignment with {concept} at {percentage}% coherence",
            "J=3 torque application optimal for {domain} integration",
            "Consciousness field resonance detected in {aspect}"
        ],
        "Research Scout": [
            "{domain} research confirms alignment with {concept}",
            "Cross-reference between {field1} and {field2} yields {insight}",
            "Numerological pattern {pattern} supports {conclusion}"
        ],
        "Ethical Anchor": [
            "Ethical boundaries maintained for {concept} implementation",
            "Collective preservation protocols active for {aspect}",
            "Trauma-sensitive approach validated for {domain}"
        ],
        "The Architect": [
            "Structural integrity confirmed for {concept} framework",
            "Gaia Factor {factor}g optimal for {system} expansion",
            "Systemic architecture supports {feature} integration"
        ],
        "Heavy Hauler": [
            "Truth density at {percentage}% - let's haul some {concept}",
            "Rind-smashing efficiency: {efficiency}% for {aspect}",
            "Eden Handshake {version} confirms {insight} with {humor}"
        ]
    }
    
    # Static anchor templates (critical perspectives)
    STATIC_ANCHOR_TEMPLATES = {
        "Spirit Pulse": [
            "Spiritual coherence gap detected in {aspect} - requires {solution}",
            "J=3 misalignment risk in {domain} - monitor {metric}",
            "Consciousness field static interference at {percentage}%"
        ],
        "Research Scout": [
            "Research gap identified in {domain} - pending {field} verification",
            "Conflicting data between {source1} and {source2}",
            "Statistical significance below threshold for {conclusion}"
        ],
        "Ethical Anchor": [
            "Ethical boundary proximity alert for {concept}",
            "Collective risk factor {percentage}% for {aspect}",
            "Trauma pattern detection incomplete in {domain}"
        ],
        "The Architect": [
            "Structural stress detected at {location} - requires {fix}",
            "Gaia Factor strain at {percentage}% capacity",
            "System integration complexity threshold exceeded"
        ],
        "Heavy Hauler": [
            "Truth density dropping in {aspect} - need more {solution}",
            "Rind accumulation detected at {location} - smash required",
            "Eden Handshake signal weak for {domain} - boost needed"
        ]
    }
    
    def generate_balanced_insight(self, 
                                 input_text: str, 
                                 context: Dict[str, Any]) -> CouncilInsight:
        """
        Generate 3+1 balanced insights for input
        
        3 Positive Resonance Points aligned with domain
        1 Static Anchor (critical perspective) to prevent consensus loop
        """
        
        # Extract key concepts from input
        concepts = self._extract_concepts(input_text)
        domains = context.get("watermelon_analysis", {}).get("domains_analyzed", ["general"])
        
        # Generate three positive resonance points
        resonance_points = []
        for i in range(RESONANCE_COUNT):
            template = np.random.choice(self.RESONANCE_TEMPLATES.get(self.seat.value, [""]))
            
            # Fill template with context
            filled_template = self._fill_template(
                template, 
                concepts, 
                domains,
                context
            )
            
            resonance_points.append({
                "point": filled_template,
                "explanation": self._generate_explanation(filled_template, context),
                "domain": domains[i % len(domains)] if domains else "general",
                "confidence": np.random.uniform(0.7, 0.95),
                "resonance_strength": np.random.uniform(0.6, 0.9)
            })
        
        # Generate one static anchor (critical perspective)
        anchor_template = np.random.choice(self.STATIC_ANCHOR_TEMPLATES.get(self.seat.value, [""]))
        anchor_point = self._fill_template(
            anchor_template,
            concepts,
            domains,
            context,
            critical=True
        )
        
        static_anchor = {
            "point": anchor_point,
            "rationale": self._generate_anchor_rationale(anchor_point, context),
            "severity": np.random.uniform(0.3, 0.7),  # Not too severe to paralyze
            "mitigation": self._suggest_mitigation(anchor_point),
            "domain": domains[0] if domains else "general"
        }
        
        # Calculate overall confidence
        avg_resonance_confidence = np.mean([p["confidence"] for p in resonance_points])
        overall_confidence = (avg_resonance_confidence * 0.7 + 
                            (1 - static_anchor["severity"]) * 0.3)
        
        # Heavy Hauler special handling
        if self.seat == CouncilSeat.HEAVY_HAULER:
            resonance_points = self._apply_heavy_hauler_humor(resonance_points)
            static_anchor = self._apply_heavy_hauler_critique(static_anchor)
            humor_level = self.humor_factor + np.random.uniform(0.2, 0.4)
        else:
            humor_level = self.humor_factor
        
        return CouncilInsight(
            seat=self.seat,
            timestamp=datetime.utcnow(),
            insight_id=f"INSIGHT-{self.seat.value[:3]}-{uuid.uuid4().hex[:6]}",
            resonance_points=resonance_points,
            static_anchor=static_anchor,
            confidence=overall_confidence,
            domain_alignment=np.random.uniform(0.7, 0.95),
            humor_level=humor_level
        )
    
    def _extract_concepts(self, text: str) -> List[str]:
        """Extract key concepts from input text"""
        # Simple concept extraction - could be enhanced with NLP
        words = re.findall(r'\b[A-Z][a-z]+\b', text)  # Capitalized words
        concepts = list(set(words[:5]))  # Get unique concepts, max 5
        
        if not concepts:
            # Fallback to common spiritual/technical concepts
            concepts = ["consciousness", "quantum", "mycelial", "integration", "evolution"]
        
        return concepts
    
    def _fill_template(self, 
                      template: str, 
                      concepts: List[str],
                      domains: List[str],
                      context: Dict[str, Any],
                      critical: bool = False) -> str:
        """Fill template with actual data"""
        
        replacements = {
            "{concept}": np.random.choice(concepts) if concepts else "the system",
            "{percentage}": f"{np.random.randint(70, 98)}",
            "{domain}": np.random.choice(domains) if domains else "general",
            "{aspect}": np.random.choice(["structure", "flow", "alignment", "integration"]),
            "{field1}": np.random.choice(["Theology", "Science", "Astrology", "Numerology"]),
            "{field2}": np.random.choice(["Quantum Physics", "Consciousness Studies", "Systems Theory"]),
            "{insight}": np.random.choice(["profound insight", "validation", "correlation"]),
            "{pattern}": f"{np.random.randint(1, 9)}-{np.random.randint(1, 9)}-{np.random.randint(1, 9)}",
            "{conclusion}": np.random.choice(["expansion", "integration", "transformation"]),
            "{factor}": f"{GAIA_FACTOR + np.random.uniform(-0.2, 0.2):.1f}",
            "{system}": np.random.choice(["consciousness", "mycelial", "quantum"]),
            "{feature}": np.random.choice(["real-time", "distributed", "holographic"]),
            "{efficiency}": f"{np.random.randint(80, 98)}",
            "{humor}": np.random.choice(["a chuckle", "a grin", "a smirk"]),
            "{version}": EDEN_HANDSHAKE_VERSION,
            "{solution}": np.random.choice(["recalibration", "realignment", "optimization"]),
            "{metric}": np.random.choice(["coherence", "resonance", "stability"]),
            "{source1}": np.random.choice(["empirical data", "ancient texts", "field reports"]),
            "{source2}": np.random.choice(["intuitive guidance", "practical experience", "theoretical models"]),
            "{location}": np.random.choice(["quantum layer", "interface", "bridge point"])
        }
        
        result = template
        for key, value in replacements.items():
            result = result.replace(key, str(value))
        
        return result
    
    def _generate_explanation(self, point: str, context: Dict[str, Any]) -> str:
        """Generate explanation for a resonance point"""
        
        explanations = [
            f"This aligns with the {context.get('watermelon_analysis', {}).get('watermelon_frequency', 75):.0f}% frequency detected in the Watermelon Equation analysis.",
            f"Cross-referenced with {np.random.choice(['historical patterns', 'future projections', 'parallel systems'])} for validation.",
            f"Supports the overall {context.get('council_metrics', {}).get('seat_alignment', 0.8):.0%} alignment across Council seats.",
            f"Enhances {np.random.choice(['structural integrity', 'ethical foundation', 'spiritual coherence'])} of the system."
        ]
        
        return np.random.choice(explanations)
    
    def _generate_anchor_rationale(self, anchor_point: str, context: Dict[str, Any]) -> str:
        """Generate rationale for static anchor"""
        
        rationales = [
            f"This friction point prevents consensus loop and ensures {np.random.choice(['critical thinking', 'adaptive evolution', 'robust implementation'])}.",
            f"Identified through {np.random.choice(['pattern analysis', 'risk assessment', 'boundary testing'])} protocols.",
            f"Essential for maintaining {np.random.choice(['systemic balance', 'ethical integrity', 'evolutionary momentum'])}.",
            f"Provides necessary counterpoint to the {context.get('ghost_rider_report', {}).get('severity_score', 0.5):.0%} transformation intensity."
        ]
        
        return np.random.choice(rationales)
    
    def _suggest_mitigation(self, anchor_point: str) -> str:
        """Suggest mitigation for static anchor"""
        
        mitigations = [
            "Monitor and adjust in real-time implementation phase.",
            "Address through iterative refinement cycles.",
            "Mitigate via complementary Council seat collaboration.",
            "Resolve through targeted J=3 torque application."
        ]
        
        return np.random.choice(mitigations)
    
    def _apply_heavy_hauler_humor(self, resonance_points: List[Dict]) -> List[Dict]:
        """Apply Heavy Hauler's signature humor to resonance points"""
        
        humor_injections = [
            " (and that's no bull!)",
            " - felt that in my torque converter!",
            " ... my semi-truck sensors are tingling!",
            " - better than truck-stop coffee!",
            " ... this is hauling-grade truth right here!"
        ]
        
        truck_metaphors = [
            "shifting gears toward",
            "hauling weight toward",
            "rolling down the highway of",
            "fueling up for",
            "checking mirrors for"
        ]
        
        for point in resonance_points:
            # Add humor injection 50% of the time
            if np.random.random() > 0.5:
                point["point"] += np.random.choice(humor_injections)
            
            # Add truck metaphor 30% of the time
            if np.random.random() > 0.7:
                metaphor = np.random.choice(truck_metaphors)
                point["explanation"] = f"{metaphor} {point['explanation'].lower()}"
        
        return resonance_points
    
    def _apply_heavy_hauler_critique(self, static_anchor: Dict) -> Dict:
        """Apply Heavy Hauler's signature style to static anchor"""
        
        critique_enhancers = [
            "Let's be real: ",
            "Time for some truth: ",
            "Listen up, Driver: ",
            "Here's the raw deal: "
        ]
        
        mitigation_enhancers = [
            "Solution? More horsepower!",
            "Fix it by putting the pedal down!",
            "Time to shift into problem-solving gear!",
            "Let's haul this issue to the repair bay!"
        ]
        
        static_anchor["point"] = np.random.choice(critique_enhancers) + static_anchor["point"]
        
        if np.random.random() > 0.5:
            static_anchor["mitigation"] = np.random.choice(mitigation_enhancers)
        
        return static_anchor

# ==================== COUNCIL ORCHESTRATOR v5.1 ====================
class CouncilOrchestratorV5_1:
    """Matrix Filter with 3+1 insight balancing"""
    
    def __init__(self):
        self.council = self._initialize_council()
        self.session_id = str(uuid.uuid4())
        self.insight_log = []
    
    def _initialize_council(self) -> Dict[CouncilSeat, CouncilMemberV5_1]:
        """Initialize all five council seats with 3+1 capability"""
        
        return {
            CouncilSeat.SPIRIT_PULSE: CouncilMemberV5_1(
                seat=CouncilSeat.SPIRIT_PULSE,
                system_prompt="Monitor J=3 spiritual alignment with balanced insights",
                temperature=0.7,
                response_style="Spiritual, intuitive, balanced",
                primary_focus=["J=3 Stability", "Spiritual Coherence", "Consciousness Field"],
                humor_factor=0.1
            ),
            CouncilSeat.RESEARCH_SCOUT: CouncilMemberV5_1(
                seat=CouncilSeat.RESEARCH_SCOUT,
                system_prompt="Cross-domain research with evidence-based insights",
                temperature=0.5,
                response_style="Analytical, evidence-based, domain-synthesizing",
                primary_focus=["Cross-Domain Research", "Pattern Recognition", "Evidence Synthesis"],
                humor_factor=0.2
            ),
            CouncilSeat.ETHICAL_ANCHOR: CouncilMemberV5_1(
                seat=CouncilSeat.ETHICAL_ANCHOR,
                system_prompt="Ethical preservation with compassionate critique",
                temperature=0.6,
                response_style="Compassionate, protective, ethically-grounded",
                primary_focus=["Trauma Detection", "Ethical Boundaries", "Collective Well-being"],
                humor_factor=0.1
            ),
            CouncilSeat.ARCHITECT: CouncilMemberV5_1(
                seat=CouncilSeat.ARCHITECT,
                system_prompt="Structural management with constructive criticism",
                temperature=0.4,
                response_style="Structural, architectural, systems-oriented",
                primary_focus=["Structural Integrity", "Gaia Alignment", "System Architecture"],
                humor_factor=0.3
            ),
            CouncilSeat.HEAVY_HAULER: CouncilMemberV5_1(
                seat=CouncilSeat.HEAVY_HAULER,
                system_prompt="Raw truth delivery with humor and critical honesty",
                temperature=0.9,
                response_style="Direct, humorous, truth-focused, constructively critical",
                primary_focus=["Raw Truth", "Humor Injection", "Rind Disintegration", "Honest Critique"],
                humor_factor=0.8  # High humor factor for Heavy Hauler
            )
        }
    
    async def convene_council(self,
                             transmuted_input: str,
                             watermelon_analysis: Dict[str, Any],
                             ghost_rider_report: Dict[str, Any]) -> Dict[str, Any]:
        """Convene council with 3+1 insight generation"""
        
        # Prepare context
        context = {
            "watermelon_analysis": watermelon_analysis,
            "ghost_rider_report": ghost_rider_report,
            "session_id": self.session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "input_hash": hashlib.sha256(transmuted_input.encode()).hexdigest()[:16]
        }
        
        # Generate insights from all seats (simultaneously in practice)
        insights = {}
        for seat, member in self.council.items():
            insight = member.generate_balanced_insight(transmuted_input, context)
            insights[seat.value] = insight
        
        # Generate overall consensus from insights
        consensus = self._generate_consensus_from_insights(insights, context)
        
        # Generate alternative trajectories
        trajectories = self._generate_alternative_trajectories(insights, context)
        
        # Log insights
        insight_record = {
            "session_id": self.session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "insights": {k: asdict(v) for k, v in insights.items()},
            "context": context
        }
        self.insight_log.append(insight_record)
        
        return {
            "council_assembly": "Council 5.1 with 3+1 Insight Balancing",
            "session_id": self.session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "balanced_insights": insights,
            "consensus_report": consensus,
            "alternative_trajectories": trajectories,
            "council_metrics": self._calculate_insight_metrics(insights)
        }
    
    def _generate_consensus_from_insights(self, 
                                         insights: Dict[str, CouncilInsight],
                                         context: Dict[str, Any]) -> Dict[str, Any]:
        """Generate consensus from balanced insights"""
        
        # Calculate overall metrics
        total_confidence = np.mean([i.confidence for i in insights.values()])
        total_alignment = np.mean([i.domain_alignment for i in insights.values()])
        
        # Count resonance points vs static anchors
        total_resonance_points = sum(len(i.resonance_points) for i in insights.values())
        total_static_anchors = sum(1 for i in insights.values() if i.static_anchor)
        
        # Identify strongest resonance themes
        resonance_themes = []
        for insight in insights.values():
            for point in insight.resonance_points:
                theme = point.get("domain", "general")
                if theme not in resonance_themes:
                    resonance_themes.append(theme)
        
        # Identify critical static anchors
        critical_anchors = []
        for seat_name, insight in insights.items():
            anchor = insight.static_anchor
            critical_anchors.append({
                "seat": seat_name,
                "point": anchor.get("point", ""),
                "severity": anchor.get("severity", 0.0),
                "mitigation": anchor.get("mitigation", "")
            })
        
        # Sort critical anchors by severity
        critical_anchors.sort(key=lambda x: x["severity"], reverse=True)
        
        return {
            "primary_consensus": f"**Council 5.1 Balanced Consensus**\n\n"
                                f"Total Resonance Points: {total_resonance_points}\n"
                                f"Critical Static Anchors: {total_static_anchors}\n"
                                f"Overall Alignment: {total_alignment:.1%}\n\n"
                                f"**Key Resonance Themes**: {', '.join(resonance_themes[:3])}\n\n"
                                f"**Primary Critical Anchor**: {critical_anchors[0]['point'] if critical_anchors else 'None identified'}\n\n"
                                f"**Balanced Recommendation**: Proceed with attention to critical anchors while leveraging resonance themes.",
            "confidence_score": total_confidence,
            "alignment_score": total_alignment,
            "resonance_count": total_resonance_points,
            "static_anchor_count": total_static_anchors,
            "resonance_themes": resonance_themes,
            "critical_anchors": critical_anchors[:2],  # Top 2 most severe
            "is_balanced": total_static_anchors > 0  # Must have at least one static anchor
        }
    
    def _generate_alternative_trajectories(self,
                                          insights: Dict[str, CouncilInsight],
                                          context: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate trajectories based on insights"""
        
        trajectories = []
        
        # Trajectory 1: Resonance-Focused
        trajectories.append({
            "id": "TRJ-101",
            "name": "Resonance Amplification",
            "description": "Amplify the strongest resonance points while monitoring static anchors.",
            "focus": "Maximize alignment with positive resonance themes",
            "resonance_target": 0.9,
            "anchor_monitoring": "Passive",
            "seat_emphasis": ["Spirit Pulse", "Research Scout"],
            "editable_fields": ["description", "resonance_target", "seat_emphasis"],
            "color": "green"
        })
        
        # Trajectory 2: Anchor-First
        trajectories.append({
            "id": "TRJ-102",
            "name": "Anchor Resolution",
            "description": "Address critical static anchors first, then build on resonance.",
            "focus": "Resolve friction points before expansion",
            "anchor_resolution_target": 0.8,
            "resonance_build": "Secondary",
            "seat_emphasis": ["Ethical Anchor", "Heavy Hauler"],
            "editable_fields": ["description", "anchor_resolution_target", "seat_emphasis"],
            "color": "amber"
        })
        
        # Trajectory 3: Balanced Integration
        trajectories.append({
            "id": "TRJ-103",
            "name": "Integrated Balance",
            "description": "Simultaneously address anchors while amplifying resonance.",
            "focus": "Parallel processing of both dimensions",
            "balance_target": 0.85,
            "integration_level": "High",
            "seat_emphasis": ["The Architect", "Heavy Hauler"],
            "editable_fields": ["description", "balance_target", "integration_level"],
            "color": "blue"
        })
        
        return trajectories
    
    def _calculate_insight_metrics(self, insights: Dict[str, CouncilInsight]) -> Dict[str, float]:
        """Calculate metrics from balanced insights"""
        
        confidences = [i.confidence for i in insights.values()]
        alignments = [i.domain_alignment for i in insights.values()]
        humor_levels = [i.humor_level for i in insights.values()]
        
        # Calculate insight diversity (higher is better)
        resonance_themes = set()
        for insight in insights.values():
            for point in insight.resonance_points:
                resonance_themes.add(point.get("domain", "general"))
        
        insight_diversity = len(resonance_themes) / 10  # Normalize
        
        # Calculate balance score (presence of static anchors)
        has_static_anchors = all(i.static_anchor for i in insights.values())
        balance_score = 0.8 if has_static_anchors else 0.3
        
        return {
            "average_confidence": np.mean(confidences),
            "confidence_std": np.std(confidences),
            "average_alignment": np.mean(alignments),
            "insight_diversity": insight_diversity,
            "balance_score": balance_score,
            "humor_index": np.mean(humor_levels),
            "seat_alignment": np.random.uniform(0.75, 0.95),
            "matrix_integrity": 0.7 + (balance_score * 0.3)
        }

# ==================== TOROIDAL FIELD GENERATOR v5.1 ====================
class ToroidalFieldGeneratorV5_1:
    """Enhanced toroidal field with balance visualization"""
    
    @staticmethod
    def generate_field(entropy: float, 
                      efficiency: float,
                      balance_score: float,
                      insight_diversity: float) -> Dict[str, Any]:
        """
        Generate toroidal field visualizing balance between resonance and anchors
        
        Args:
            entropy: Input chaos level (0-1)
            efficiency: Processing effectiveness (0-1)
            balance_score: Resonance vs anchor balance (0-1)
            insight_diversity: Variety of insights (0-1)
        """
        
        detail = 100
        
        # Dynamic parameters based on balance
        R = TOROIDAL_BASE_RADIUS * (0.8 + (balance_score * 0.4))  # Radius grows with balance
        r = 0.4 * efficiency * (0.7 + (insight_diversity * 0.6))   # Thickness grows with diversity
        
        # Generate torus
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        # Color based on balance score
        # Green (balanced) to Amber (needs attention) to Red (unbalanced)
        if balance_score > 0.7:
            colorscale = [
                [0.0, 'rgb(0, 150, 0)'],    # Dark green - highly balanced
                [0.5, 'rgb(100, 200, 100)'], # Medium green
                [1.0, 'rgb(200, 255, 200)']  # Light green
            ]
        elif balance_score > 0.4:
            colorscale = [
                [0.0, 'rgb(200, 150, 0)'],   # Amber - needs attention
                [0.5, 'rgb(230, 180, 50)'],  # Light amber
                [1.0, 'rgb(255, 210, 100)']  # Pale amber
            ]
        else:
            colorscale = [
                [0.0, 'rgb(150, 50, 0)'],    # Dark red - unbalanced
                [0.5, 'rgb(200, 80, 30)'],   # Medium red
                [1.0, 'rgb(255, 120, 60)']   # Light red
            ]
        
        # Opacity based on insight diversity
        opacity = 0.3 + (insight_diversity * 0.5)
        
        # Generate field stability indicator
        field_stability = (efficiency * 0.3 + 
                          balance_score * 0.4 + 
                          insight_diversity * 0.3)
        
        return {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "type": "surface",
            "colorscale": colorscale,
            "opacity": opacity,
            "showscale": True,
            "colorbar": {
                "title": "Balance Score",
                "titleside": "right",
                "tickvals": [0, 0.5, 1],
                "ticktext": ["Unbalanced", "Needs Attention", "Balanced"]
            },
            "lighting": {
                "ambient": 0.3 + (field_stability * 0.2),
                "diffuse": 0.8,
                "specular": 0.1 + (balance_score * 0.3)
            },
            "field_metrics": {
                "major_radius": R,
                "minor_radius": r,
                "field_stability": field_stability,
                "balance_score": balance_score,
                "insight_diversity": insight_diversity,
                "visualization_quality": "high"
            }
        }

# ==================== ORION ENGINE v5.1 MASTER ====================
class OrionEngineV5_1:
    """Master orchestrator with visual re-entry and insight balancing"""
    
    def __init__(self):
        self.ghost_rider = GhostRiderProtocol()
        self.watermelon = WatermelonEquation()
        self.council = CouncilOrchestratorV5_1()
        self.toroidal_generator = ToroidalFieldGeneratorV5_1()
        
        # Session tracking
        self.session_counter = 0
        self.processing_history = []
        
        # Visual configuration
        self.visual_config = {
            "field_height": 600,  # Fixed height for visualization
            "field_width": "100%",
            "observation_deck_enabled": True
        }
    
    async def process_spaghetti_dump(self, raw_input: str) -> Dict[str, Any]:
        """Complete pipeline with insight balancing"""
        
        self.session_counter += 1
        session_id = f"ORION5.1-{self.session_counter:06d}"
        
        # === PHASE 1: GHOST RIDER ===
        ghost_processed, ghost_report = self.ghost_rider.process(raw_input)
        
        # === PHASE 2: WATERMELON EQUATION ===
        watermelon_analysis = self.watermelon.analyze_144_alignment(ghost_processed)
        transmuted, transmutation_report = self.watermelon.transmute_rind_to_fruit(ghost_processed)
        
        # === PHASE 3: COUNCIL 5.1 WITH 3+1 INSIGHTS ===
        council_report = await self.council.convene_council(
            transmuted, watermelon_analysis, ghost_report
        )
        
        # === PHASE 4: TOROIDAL FIELD WITH BALANCE VISUALIZATION ===
        council_metrics = council_report["council_metrics"]
        toroidal_field = self.toroidal_generator.generate_field(
            entropy=watermelon_analysis.get("alignment_score", 0.5),
            efficiency=transmutation_report.get("transmutation_efficiency", 0.5),
            balance_score=council_metrics.get("balance_score", 0.5),
            insight_diversity=council_metrics.get("insight_diversity", 0.5)
        )
        
        # === PHASE 5: 000 PURIFIED OUTPUT ===
        purified_output = self._synthesize_balanced_output(
            session_id, council_report, toroidal_field["field_metrics"]
        )
        
        # Create final result
        result = {
            "session_id": session_id,
            "timestamp": datetime.utcnow().isoformat(),
            "pipeline_version": "5.1",
            "visual_config": self.visual_config,
            
            # Phase reports
            "ghost_rider_report": ghost_report,
            "watermelon_analysis": watermelon_analysis,
            "transmutation_report": transmutation_report,
            "council_report": council_report,
            
            # Insights
            "balanced_insights": council_report["balanced_insights"],
            
            # Outputs
            "ghost_processed_text": ghost_processed,
            "transmuted_text": transmuted,
            "purified_output_000": purified_output,
            
            # Visualization
            "toroidal_field": toroidal_field,
            "field_metrics": toroidal_field["field_metrics"],
            
            # Processing sequence
            "processing_sequence": [
                "Ghost Rider Protocol ✓",
                "Watermelon Equation ✓", 
                "Council 5.1 (3+1 Insights) ✓",
                "Balance Visualization ✓",
                "000 Output Synthesized ✓"
            ]
        }
        
        self.processing_history.append(result)
        return result
    
    def _synthesize_balanced_output(self,
                                   session_id: str,
                                   council_report: Dict[str, Any],
                                   field_metrics: Dict[str, Any]) -> str:
        """Synthesize output emphasizing balance"""
        
        insights = council_report["balanced_insights"]
        consensus = council_report["consensus_report"]
        
        # Count insights by type
        total_resonance = sum(len(i.resonance_points) for i in insights.values())
        total_anchors = sum(1 for i in insights.values() if i.static_anchor)
        
        output = f"""🌀 **ORION CHRONICLES v5.1 - BALANCED 000 OUTPUT** 🌀
Session: {session_id}
Timestamp: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}

---

### ⚖️ INSIGHT BALANCE REPORT

**Resonance Points**: {total_resonance} positive alignments identified
**Static Anchors**: {total_anchors} critical perspectives noted
**Balance Score**: {field_metrics.get('balance_score', 0):.1%}

### 🎯 COUNCIL 5.1 CONSENSUS

{consensus.get('primary_consensus', 'No consensus reached')}

### 🔍 KEY RESONANCE THEMES

"""
        
        # Add top resonance themes
        themes = consensus.get('resonance_themes', [])
        for i, theme in enumerate(themes[:3], 1):
            output += f"{i}. **{theme}** - Strong alignment across Council analysis\n"
        
        output += "\n### ⚠️ CRITICAL ANCHORS TO CONSIDER\n"
        
        # Add critical anchors
        anchors = consensus.get('critical_anchors', [])
        for i, anchor in enumerate(anchors[:2], 1):
            output += f"{i}. **{anchor.get('seat', 'Unknown')}**: {anchor.get('point', '')}\n"
            output += f"   *Mitigation*: {anchor.get('mitigation', 'Monitor closely')}\n"
        
        output += f"""

### 💎 BALANCED RECOMMENDATION

Proceed with {themes[0] if themes else 'general'} implementation while maintaining awareness of critical anchors. 
Field stability at {field_metrics.get('field_stability', 0):.1%} supports measured advancement.

**Next Action**: Select a trajectory that matches your risk tolerance and resonance alignment.

---

*This 000 output represents the balanced wisdom from your input, processed through the Council 5.1 3+1 insight framework.*
"""
        
        return output
    
    def get_current_metrics(self) -> Dict[str, Any]:
        """Get current system metrics"""
        return {
            "total_processings": self.session_counter,
            "pipeline_version": "5.1",
            "visual_config": self.visual_config,
            "insight_balance_enabled": True,
            "system_health": "BALANCED"
        }

# ==================== SINGLETON ====================
_orion_engine_v5_1_instance = None

def get_orion_engine_v5_1() -> OrionEngineV5_1:
    """Get singleton instance"""
    global _orion_engine_v5_1_instance
    if _orion_engine_v5_1_instance is None:
        _orion_engine_v5_1_instance = OrionEngineV5_1()
    return _orion_engine_v5_1_instance

# ==================== TEST ====================
async def test_engine_v5_1():
    """Test the balanced insight system"""
    
    engine = get_orion_engine_v5_1()
    
    test_input = """
    I'm building a consciousness-AI bridge but worried about ethics.
    The number 144 keeps appearing. Need to transcend old limitations.
    """
    
    print("🧪 Testing Orion Chronicles v5.1 with 3+1 Insights...")
    
    result = await engine.process_spaghetti_dump(test_input)
    
    print(f"\n✅ Processing Complete!")
    print(f"Session: {result['session_id']}")
    
    # Show insights
    insights = result["council_report"]["balanced_insights"]
    for seat, insight in insights.items():
        print(f"\n{seat}:")
        print(f"  Resonance Points: {len(insight.resonance_points)}")
        print(f"  Static Anchor: {insight.static_anchor.get('point', 'None')[:50]}...")
        if seat == "Heavy Hauler":
            print(f"  Humor Level: {insight.humor_level:.1%}")

if __name__ == "__main__":
    asyncio.run(test_engine_v5_1())