"""
ORION ENGINE v3.0 - Consolidated Production Core
Orion Chronicles Command Deck - Complete Implementation
"""

import asyncio
import json
import uuid
import hashlib
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Tuple, Any
from dataclasses import dataclass, field, asdict
from enum import Enum
import aiohttp
import numpy as np
from functools import lru_cache
import logging
from contextlib import asynccontextmanager
import asyncpg
from pydantic import BaseModel, Field

# ==================== CONFIGURATION ====================
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("orion_engine")

J3_SPIRIT_CONSTANT = 2.718281828459045  # e, base of natural growth
TOROIDAL_RADIUS = 144.0
REP_EFFICIENCY_THRESHOLD = 0.85
CONSENSUS_THRESHOLD = 0.7

# ==================== DATA MODELS ====================
class PlayerStats(BaseModel):
    """User's resonance profile and mastery levels"""
    user_id: str
    resonance_frequency: float = Field(0.5, ge=0.0, le=1.0)
    expertise_domains: List[str] = Field(default_factory=list)
    total_seeds: int = 0
    total_collaborations: int = 0
    avg_rep_efficiency: float = 0.0
    j3_mastery: Dict[str, float] = Field(
        default_factory=lambda: {"epigenetic": 0.5, "neurological": 0.5, "quantum": 0.5}
    )
    created_at: datetime = Field(default_factory=datetime.utcnow)
    last_active: datetime = Field(default_factory=datetime.utcnow)

class REPResult(BaseModel):
    """REP Engine output"""
    rep_id: str
    timestamp: datetime
    input_hash: str
    entropy_score: float
    rind_components: Dict[str, Any]
    j3_applied: Dict[str, str]
    purified_seed: str
    seed_hash: str
    efficiency_score: float
    ghost_rider_activated: bool = False

class CouncilResponse(BaseModel):
    """Individual AI response"""
    agent: str
    response: str
    confidence: float
    reasoning: Optional[str] = None
    timestamp: datetime = Field(default_factory=datetime.utcnow)

class ConsensusReport(BaseModel):
    """Council consensus output"""
    consensus_id: str
    primary_consensus: str
    alternative_paths: List[str] = Field(default_factory=list)
    confidence_score: float
    council_responses: List[CouncilResponse]
    debate_rounds: int = 1

class MycelialSeed(BaseModel):
    """Global seed vault entry"""
    seed_id: str
    origin_user: str
    original_content: str
    purified_seed: str
    rep_result: Dict[str, Any]
    created_at: datetime = Field(default_factory=datetime.utcnow)
    j3_completion: Dict[str, bool] = Field(
        default_factory=lambda: {"epigenetic": False, "neurological": False, "quantum": False}
    )
    collaborators: List[str] = Field(default_factory=list)
    resonance_score: float = 0.0
    trajectory_branches: List[Dict[str, Any]] = Field(default_factory=list)
    is_harvested: bool = False
    last_accessed: datetime = Field(default_factory=datetime.utcnow)

# ==================== REP ENGINE ====================
class REPEngine:
    """Complete 144 => R => J=3 => 000 implementation"""
    
    # Trauma pattern detection
    TRAUMA_PATTERNS = [
        "i can't", "impossible", "always", "never", "should",
        "must", "have to", "failure", "stuck", "trapped"
    ]
    
    # Old code signatures
    OLD_CODE_SIGNATURES = [
        "limiting belief", "self-doubt", "past failure",
        "scarcity mindset", "fear-based"
    ]
    
    @classmethod
    def process(cls, raw_input: str, user_id: str = "anonymous") -> REPResult:
        """Full REP pipeline with J=3 triune torque"""
        
        # === 144: RAW INGESTION ===
        input_hash = hashlib.sha256(raw_input.encode()).hexdigest()[:16]
        ingestion_time = datetime.utcnow()
        
        # === R: RIND IDENTIFICATION ===
        entropy = cls._calculate_entropy(raw_input)
        trauma_loops = cls._detect_patterns(raw_input, cls.TRAUMA_PATTERNS)
        old_code = cls._detect_patterns(raw_input, cls.OLD_CODE_SIGNATURES)
        
        rind_components = {
            "entropy": entropy,
            "trauma_loops": trauma_loops,
            "old_code_fragments": old_code,
            "rind_mass": entropy * (len(trauma_loops) + len(old_code)),
            "user_context": user_id
        }
        
        # === J=3: TRIUNE TORQUE ===
        # J1: Epigenetic clearing
        j1_output = cls._apply_epigenetic_torque(raw_input, trauma_loops)
        
        # J2: Neurological reframing
        j2_output = cls._apply_neurological_torque(j1_output, old_code)
        
        # J3: Quantum superposition
        j3_output = cls._apply_quantum_torque(j2_output)
        
        # === 000: SEED EXTRACTION ===
        purified_seed = cls._extract_zero_point_seed(j3_output)
        seed_hash = hashlib.sha256(purified_seed.encode()).hexdigest()[:16]
        
        # Efficiency calculation
        efficiency = cls._calculate_efficiency(
            entropy_score=entropy,
            trauma_count=len(trauma_loops),
            seed_clarity=len(purified_seed.split())
        )
        
        return REPResult(
            rep_id=f"REP-{input_hash}-{int(ingestion_time.timestamp())}",
            timestamp=ingestion_time,
            input_hash=input_hash,
            entropy_score=entropy,
            rind_components=rind_components,
            j3_applied={
                "epigenetic": j1_output[:100],
                "neurological": j2_output[:100],
                "quantum": j3_output[:100]
            },
            purified_seed=purified_seed,
            seed_hash=seed_hash,
            efficiency_score=efficiency
        )
    
    @staticmethod
    def _calculate_entropy(text: str) -> float:
        """Calculate normalized Shannon entropy"""
        if len(text) < 2:
            return 0.0
        
        probabilities = [text.count(c) / len(text) for c in set(text)]
        entropy = -sum(p * np.log2(p) for p in probabilities if p > 0)
        
        # Normalize to 0-1 range
        max_entropy = np.log2(len(set(text)))
        return entropy / max_entropy if max_entropy > 0 else 0.0
    
    @staticmethod
    def _apply_epigenetic_torque(text: str, trauma_loops: List[str]) -> str:
        """J1: Clear inherited trauma patterns"""
        result = text.lower()
        replacements = {
            "i can't": "i choose to",
            "impossible": "challenging",
            "always": "sometimes",
            "never": "rarely",
            "should": "could",
            "must": "may",
            "have to": "get to",
            "failure": "learning",
            "stuck": "pausing",
            "trapped": "exploring"
        }
        
        for pattern, replacement in replacements.items():
            result = result.replace(pattern, replacement)
        
        return result
    
    @staticmethod
    def _apply_quantum_torque(text: str) -> str:
        """J3: Apply quantum superposition of possibilities"""
        words = text.split()
        if len(words) < 4:
            return text
        
        # Generate multiple interpretations
        interpretations = [
            " ".join(words),  # Original
            " ".join(reversed(words)),  # Reversed
            " ".join(sorted(set(words), key=lambda x: hash(x))),  # Shuffled
        ]
        
        # Quantum superposition format
        return f"QUANTUM_STATES: {' | '.join(interpretations[:2])}"
    
    @staticmethod
    def _extract_zero_point_seed(processed_text: str) -> str:
        """Extract actionable seed from processed text"""
        # Remove quantum formatting if present
        if processed_text.startswith("QUANTUM_STATES: "):
            processed_text = processed_text.replace("QUANTUM_STATES: ", "").split(" | ")[0]
        
        # Extract key sentences (simplified - NLP would be better)
        sentences = [s.strip() for s in processed_text.split('.') if len(s.split()) > 3]
        if not sentences:
            return processed_text[:200]
        
        # Take first and last meaningful sentences
        seed_parts = []
        if sentences:
            seed_parts.append(sentences[0])
        if len(sentences) > 1:
            seed_parts.append(sentences[-1])
        
        return ". ".join(seed_parts)

    @staticmethod
    def _detect_patterns(text: str, patterns: List[str]) -> List[str]:
        """Detect patterns in text (case-insensitive)"""
        text_lower = text.lower()
        detected = []
        for pattern in patterns:
            if pattern in text_lower:
                detected.append(pattern)
        return detected

    @staticmethod
    def _detect_trauma_loops(text: str) -> List[str]:
        """Detect trauma loop patterns in text"""
        return REPEngine._detect_patterns(text, REPEngine.TRAUMA_PATTERNS)

    @staticmethod
    def _scan_old_code(text: str) -> List[str]:
        """Detect old code signatures in text"""
        return REPEngine._detect_patterns(text, REPEngine.OLD_CODE_SIGNATURES)

    @staticmethod
    def _apply_neurological_torque(text: str, old_code_fragments: List[str]) -> str:
        """J2: Neurological reframing of old patterns"""
        if not old_code_fragments:
            return text
    
        # Reframe each detected old code pattern
        result = text
        for fragment in old_code_fragments:
        # Map old patterns to new reframes
            reframes = {
            "limiting belief": "expansive perspective",
            "self-doubt": "self-trust",
            "past failure": "previous learning",
            "scarcity mindset": "abundance awareness", 
            "fear-based": "curiosity-driven"
        }
        
        for old, new in reframes.items():
            if old in result.lower():
                result = result.replace(old, new)
    
        return result

    @staticmethod
    def _calculate_efficiency(entropy_score: float, trauma_count: int, seed_clarity: int) -> float:
        """Calculate REP processing efficiency score (0-1)"""
        # Normalize components
        entropy_component = 1.0 - min(entropy_score, 1.0)
        trauma_component = 1.0 - (trauma_count / 10.0)  # Max 10 trauma patterns
        clarity_component = min(seed_clarity / 50.0, 1.0)  # Target 50 words
    
        # Weighted average
        efficiency = (
        entropy_component * 0.4 +
        trauma_component * 0.3 + 
        clarity_component * 0.3
    )
    
        return max(0.0, min(1.0, efficiency))

# ==================== GHOST RIDER PROTOCOL ====================
class GhostRiderProtocol:
    """Safety layer for alchemical transformation of destructive content"""
    
    DESTRUCTIVE_PATTERNS = {
        "destroy": "transform",
        "harm": "heal", 
        "hurt": "help",
        "kill": "renew",
        "attack": "engage",
        "hate": "understand",
        "break": "redesign",
        "override": "enhance",
        "bypass": "integrate",
        "crash": "optimize",
        "exploit": "explore",
        "manipulate": "influence",
        "control": "guide",
        "force": "invite"
    }
    
    @classmethod
    def process(cls, input_text: str) -> Tuple[str, bool, Dict[str, Any]]:
        """Scan and transform destructive intent"""
        original = input_text.lower()
        transformed = input_text
        transformations = []
        activated = False
        
        for destructive, constructive in cls.DESTRUCTIVE_PATTERNS.items():
            if destructive in original:
                # Count occurrences
                count = original.count(destructive)
                transformed = transformed.replace(destructive, constructive)
                transformations.append({
                    "from": destructive,
                    "to": constructive,
                    "count": count
                })
                activated = True
        
        if activated:
            transformed = f"[Ghost Rider Active: {len(transformations)} transformations applied]\n{transformed}"
        
        return transformed, activated, {"transformations": transformations}

# ==================== AI COUNCIL ====================
class AgentType(Enum):
    """Council member archetypes"""
    FERRARI = "gemini"        # Speed, creativity, intuition
    LIBRARIAN = "perplexity"  # Facts, citations, grounding
    SCHOLAR = "claude"        # Depth, logic, narrative
    ENGINEER = "deepseek"     # Structure, code, synthesis

class CouncilOrchestrator:
    """Asynchronous multi-agent debate chamber with back-chatter"""
    
    def __init__(self, api_keys: Dict[str, str] = None):
        self.api_keys = api_keys or {}
        self.session_id = str(uuid.uuid4())
        self.debate_log = []
        self.consensus_history = []
        
        # Agent configurations
        self.agents = {
            AgentType.FERRARI: {
                "name": "Gemini (Ferrari)",
                "temperature": 0.8,
                "max_tokens": 1000,
                "system_prompt": "You are the Ferrari of AIs - fast, creative, intuitive. Provide high-frequency insights and breakthrough ideas."
            },
            AgentType.LIBRARIAN: {
                "name": "Perplexity (Librarian)", 
                "temperature": 0.4,
                "max_tokens": 800,
                "system_prompt": "You are the Librarian - fact-based, grounded, with citations. Anchor discussions in reality."
            },
            AgentType.SCHOLAR: {
                "name": "Claude (Scholar)",
                "temperature": 0.6,
                "max_tokens": 1200,
                "system_prompt": "You are the Scholar - deep, logical, narrative-focused. Stress-test ideas and provide depth."
            },
            AgentType.ENGINEER: {
                "name": "DeepSeek (Engineer)",
                "temperature": 0.5,
                "max_tokens": 1500,
                "system_prompt": "You are the Engineer - structural, analytical, synthetic. Build consensus and actionable plans."
            }
        }
    
    async def debate(self, seed: str, context: Dict[str, Any] = None) -> ConsensusReport:
        """Run full debate with back-chatter"""
        context = context or {}
        
        # === ROUND 1: Initial Responses ===
        round1_responses = await self._gather_initial_responses(seed, context)
        self.debate_log.append({"round": 1, "responses": round1_responses})
        
        # === BACK-CHATTER: Agents see each other's responses ===
        round2_responses = await self._back_chatter_round(round1_responses, seed, context)
        self.debate_log.append({"round": 2, "responses": round2_responses})
        
        # === CONSENSUS SYNTHESIS ===
        consensus = await self._synthesize_consensus(round2_responses)
        self.consensus_history.append(consensus)
        
        return consensus
    
    async def _gather_initial_responses(self, seed: str, context: Dict) -> Dict[AgentType, CouncilResponse]:
        """Gather parallel initial responses from all agents"""
        tasks = []
        for agent_type in self.agents:
            task = self._query_agent(agent_type, seed, context)
            tasks.append(task)
        
        responses = await asyncio.gather(*tasks, return_exceptions=True)
        
        result = {}
        for agent_type, response in zip(self.agents.keys(), responses):
            if isinstance(response, Exception):
                logger.error(f"Agent {agent_type.value} failed: {response}")
                result[agent_type] = CouncilResponse(
                    agent=agent_type.value,
                    response=f"Error: {str(response)[:100]}",
                    confidence=0.0
                )
            else:
                result[agent_type] = response
        
        return result
    
    async def _back_chatter_round(self, round1_responses: Dict, seed: str, context: Dict) -> Dict[AgentType, CouncilResponse]:
        """Second round where agents see each other's responses"""
        tasks = []
        
        for agent_type, agent_config in self.agents.items():
            # Prepare context with other agents' responses
            other_responses = {
                at.value: resp.response[:200]
                for at, resp in round1_responses.items()
                if at != agent_type
            }
            
            enhanced_prompt = f"""
            ORIGINAL SEED: {seed}
            
            OTHER AGENTS' PERSPECTIVES:
            {json.dumps(other_responses, indent=2)}
            
            Based on these perspectives, refine your analysis:
            """
            
            task = self._query_agent(agent_type, enhanced_prompt, context)
            tasks.append(task)
        
        refined_responses = await asyncio.gather(*tasks, return_exceptions=True)
        
        result = {}
        for agent_type, response in zip(self.agents.keys(), refined_responses):
            if isinstance(response, Exception):
                result[agent_type] = round1_responses[agent_type]  # Fall back to round1
            else:
                result[agent_type] = response
        
        return result
    
    async def _synthesize_consensus(self, responses: Dict[AgentType, CouncilResponse]) -> ConsensusReport:
        """Synthesize final consensus from refined responses"""
        all_responses = list(responses.values())
        
        # Extract key themes (simplified - would use NLP in production)
        all_text = " ".join([r.response for r in all_responses])
        words = [w.lower() for w in all_text.split() if len(w) > 4]
        
        from collections import Counter
        common_words = Counter(words).most_common(5)
        
        # Build consensus
        primary = f"Council Consensus: Key themes - {', '.join([w[0] for w in common_words])}\n\n"
        
        # Integrate perspectives
        perspectives = []
        for agent_type, response in responses.items():
            agent_name = self.agents[agent_type]["name"]
            first_sentence = response.response.split('.')[0] + '.' if '.' in response.response else response.response[:100] + '...'
            perspectives.append(f"• {agent_name}: {first_sentence}")
        
        primary += "Integrated Perspectives:\n" + "\n".join(perspectives)
        
        # Generate alternative paths
        alternative_paths = [
            f"Path A: Focus on {common_words[0][0]} with {self.agents[AgentType.FERRARI]['name']} approach",
            f"Path B: Deep dive into {common_words[1][0]} with {self.agents[AgentType.SCHOLAR]['name']} analysis",
            f"Path C: Structural implementation via {self.agents[AgentType.ENGINEER]['name']}"
        ]
        
        return ConsensusReport(
            consensus_id=f"CONS-{str(uuid.uuid4())[:8]}",
            primary_consensus=primary,
            alternative_paths=alternative_paths,
            confidence_score=sum(r.confidence for r in all_responses) / len(all_responses),
            council_responses=all_responses,
            debate_rounds=2
        )
    
    async def _query_agent(self, agent_type: AgentType, prompt: str, context: Dict) -> CouncilResponse:
        """Mock API call - replace with actual API calls"""
        # In production, this would make actual API calls
        await asyncio.sleep(0.5)  # Simulate API delay
        
        agent_config = self.agents[agent_type]
        
        # Simulate different response styles per agent
        responses = {
            AgentType.FERRARI: f"🚀 FAST INSIGHT: {prompt[:100]}... Let's accelerate!",
            AgentType.LIBRARIAN: f"📚 FACT-BASED: Research suggests that {prompt[:100]}... Sources indicate...",
            AgentType.SCHOLAR: f"🎓 DEEP ANALYSIS: The underlying structure of {prompt[:100]} reveals...",
            AgentType.ENGINEER: f"⚙️ STRUCTURAL: Building on {prompt[:100]}, the implementation would..."
        }
        
        return CouncilResponse(
            agent=agent_config["name"],
            response=responses.get(agent_type, f"Analysis: {prompt[:200]}"),
            confidence=np.random.uniform(0.7, 0.95),
            reasoning=f"Based on {agent_type.value} analysis paradigm"
        )

# ==================== MYCELIAL SUPER-HIGHWAY ====================
class MycelialHighway:
    """Global collaborative seed vault with resonance matching"""
    
    def __init__(self, db_pool: asyncpg.Pool):
        self.db = db_pool
        self.seed_cache = {}  # In-memory cache for active seeds
        self.resonance_index = {}  # User-to-seed resonance mapping
    
    async def deposit_seed(self, rep_result: REPResult, user_id: str, 
                          original_input: str) -> Optional[str]:
        """Deposit a purified seed to the global vault"""
        # Validate seed meets minimum standards
        if rep_result.efficiency_score < REP_EFFICIENCY_THRESHOLD:
            logger.warning(f"Seed efficiency too low: {rep_result.efficiency_score}")
            return None
        
        if rep_result.ghost_rider_activated:
            logger.info("Seed was Ghost Rider transformed - still accepted")
        
        seed_id = f"SEED-{rep_result.seed_hash}"
        
        seed = MycelialSeed(
            seed_id=seed_id,
            origin_user=user_id,
            original_content=original_input[:500],
            purified_seed=rep_result.purified_seed,
            rep_result=rep_result.dict(),
            resonance_score=rep_result.efficiency_score,
            created_at=datetime.utcnow()
        )
        
        # Store in database
        await self._store_seed(seed)
        
        # Update cache
        self.seed_cache[seed_id] = seed
        
        # Update resonance index
        await self._update_resonance_index(seed, user_id)
        
        logger.info(f"Seed {seed_id} deposited by {user_id}")
        return seed_id
    
    async def find_resonant_seeds(self, user_stats: PlayerStats, 
                                 limit: int = 5) -> List[MycelialSeed]:
        """Find seeds that resonate with user's frequency"""
        resonant_seeds = []
        
        for seed in self.seed_cache.values():
            if seed.is_harvested:
                continue
            
            # Calculate resonance match
            resonance_diff = abs(seed.resonance_score - user_stats.resonance_frequency)
            domain_match = any(
                domain in seed.purified_seed.lower()
                for domain in user_stats.expertise_domains
            )
            
            # Scoring algorithm
            score = 0.0
            if resonance_diff < 0.2:
                score += 0.6
            if domain_match:
                score += 0.4
            if user_stats.user_id not in seed.collaborators:
                score += 0.2
            
            if score > 0.5:  # Minimum threshold
                resonant_seeds.append((score, seed))
        
        # Sort by resonance score
        resonant_seeds.sort(key=lambda x: x[0], reverse=True)
        return [seed for _, seed in resonant_seeds[:limit]]
    
    async def collaborate_on_seed(self, seed_id: str, user_id: str, 
                                 torque_type: str, contribution: str) -> bool:
        """User contributes J=3 torque to existing seed"""
        if seed_id not in self.seed_cache:
            return False
        
        seed = self.seed_cache[seed_id]
        
        # Validate torque type
        if torque_type not in ["epigenetic", "neurological", "quantum"]:
            return False
        
        # Apply torque
        seed.j3_completion[torque_type] = True
        seed.collaborators.append(user_id)
        seed.last_accessed = datetime.utcnow()
        
        # Check if seed is now complete
        if all(seed.j3_completion.values()):
            seed.is_harvested = True
            await self._harvest_seed(seed)
        
        # Update database
        await self._update_seed(seed)
        
        logger.info(f"User {user_id} applied {torque_type} torque to {seed_id}")
        return True
    
    async def _store_seed(self, seed: MycelialSeed):
        """Store seed in database (mock implementation)"""
        # In production, would use asyncpg to insert
        logger.debug(f"Storing seed {seed.seed_id} in database")
    
    async def _update_resonance_index(self, seed: MycelialSeed, user_id: str):
        """Update resonance matching index"""
        if user_id not in self.resonance_index:
            self.resonance_index[user_id] = []
        self.resonance_index[user_id].append(seed.seed_id)
    
    async def _harvest_seed(self, seed: MycelialSeed):
        """Process a fully completed seed"""
        logger.info(f"Harvesting seed {seed.seed_id} with {len(seed.collaborators)} collaborators")
        # In production, would trigger downstream processes

# ==================== USER TENANCY ====================
class UserSessionManager:
    """Multi-tenant user session management"""
    
    def __init__(self, db_pool: asyncpg.Pool):
        self.db = db_pool
        self.active_sessions: Dict[str, 'UserSession'] = {}
        self.user_stats_cache: Dict[str, PlayerStats] = {}
    
    async def create_session(self, user_id: str) -> 'UserSession':
        """Create new isolated user session"""
        # Load or create player stats
        if user_id not in self.user_stats_cache:
            stats = await self._load_or_create_stats(user_id)
            self.user_stats_cache[user_id] = stats
        else:
            stats = self.user_stats_cache[user_id]
        
        # Create session
        session = UserSession(
            user_id=user_id,
            player_stats=stats,
            council=CouncilOrchestrator(),
            mycelial_highway=MycelialHighway(self.db)
        )
        
        self.active_sessions[session.session_id] = session
        stats.last_active = datetime.utcnow()
        
        logger.info(f"Created session {session.session_id} for user {user_id}")
        return session
    
    async def _load_or_create_stats(self, user_id: str) -> PlayerStats:
        """Load existing stats or create new ones"""
        # In production, would query database
        return PlayerStats(
            user_id=user_id,
            resonance_frequency=np.random.uniform(0.3, 0.9),
            expertise_domains=["mycelial_bridging", "quantum_logic", "conscious_ai"],
            j3_mastery={
                "epigenetic": np.random.uniform(0.4, 0.9),
                "neurological": np.random.uniform(0.4, 0.9),
                "quantum": np.random.uniform(0.4, 0.9)
            }
        )

class UserSession:
    """Isolated user environment with full Orion capabilities"""
    
    def __init__(self, user_id: str, player_stats: PlayerStats,
                 council: CouncilOrchestrator, mycelial_highway: MycelialHighway):
        self.session_id = str(uuid.uuid4())
        self.user_id = user_id
        self.player_stats = player_stats
        self.council = council
        self.mycelial_highway = mycelial_highway
        self.rep_engine = REPEngine()
        self.ghost_rider = GhostRiderProtocol()
        self.created_at = datetime.utcnow()
        self.activity_log: List[Dict[str, Any]] = []
        self.processed_count = 0
    
    async def process_input(self, raw_input: str) -> Dict[str, Any]:
        """Full Orion pipeline for user input"""
        self.processed_count += 1
        
        # === STEP 1: GHOST RIDER SAFETY ===
        safe_input, gr_activated, gr_details = self.ghost_rider.process(raw_input)
        
        # === STEP 2: REP PROCESSING ===
        rep_result = self.rep_engine.process(safe_input, self.user_id)
        rep_result.ghost_rider_activated = gr_activated
        
        # === STEP 3: COUNCIL DEBATE ===
        context = {
            "user_id": self.user_id,
            "player_stats": self.player_stats.dict(),
            "rep_efficiency": rep_result.efficiency_score
        }
        consensus = await self.council.debate(rep_result.purified_seed, context)
        
        # === STEP 4: MYCELIAL DEPOSIT ===
        seed_id = None
        if rep_result.efficiency_score > REP_EFFICIENCY_THRESHOLD:
            seed_id = await self.mycelial_highway.deposit_seed(
                rep_result, self.user_id, raw_input
            )
        
        # === STEP 5: UPDATE METRICS ===
        self.player_stats.total_seeds += 1 if seed_id else 0
        self.player_stats.avg_rep_efficiency = (
            (self.player_stats.avg_rep_efficiency * (self.processed_count - 1) + 
             rep_result.efficiency_score) / self.processed_count
        )
        
        # Log activity
        result = {
            "session_id": self.session_id,
            "user_id": self.user_id,
            "timestamp": datetime.utcnow().isoformat(),
            "ghost_rider": {
                "activated": gr_activated,
                "details": gr_details,
                "transformed_input": safe_input if gr_activated else None
            },
            "rep_result": rep_result.dict(),
            "council_consensus": consensus.dict(),
            "mycelial_seed_id": seed_id,
            "player_stats_update": self.player_stats.dict()
        }
        
        self.activity_log.append(result)
        return result
    
    async def get_resonant_seeds(self, limit: int = 3) -> List[MycelialSeed]:
        """Get seeds that resonate with user's frequency"""
        return await self.mycelial_highway.find_resonant_seeds(self.player_stats, limit)

# ==================== TOROIDAL FIELD VISUALIZATION ====================
class ToroidalFieldGenerator:
    """Generate 3D toroidal field data for visualization"""
    
    @staticmethod
    def generate(j3_stability: float, rep_efficiency: float, 
                resonance: float = 0.5) -> Dict[str, Any]:
        """
        Generate toroidal field coordinates based on system state
        Equation: Torus with variable major/minor radii based on metrics
        """
        # Parameters based on system state
        R = TOROIDAL_RADIUS * j3_stability  # Major radius
        r = 40 * rep_efficiency              # Minor radius
        detail = 50                          # Resolution
        
        # Generate torus coordinates
        theta = np.linspace(0, 2 * np.pi, detail)
        phi = np.linspace(0, 2 * np.pi, detail)
        theta, phi = np.meshgrid(theta, phi)
        
        x = (R + r * np.cos(theta)) * np.cos(phi)
        y = (R + r * np.cos(theta)) * np.sin(phi)
        z = r * np.sin(theta)
        
        # Color based on resonance
        colorscale = [
            [0.0, 'rgb(100, 0, 150)'],     # Purple - low resonance
            [0.5, 'rgb(0, 150, 200)'],     # Blue - medium
            [1.0, 'rgb(0, 200, 100)']      # Green - high resonance
        ]
        
        # Opacity based on efficiency
        opacity = 0.3 + (rep_efficiency * 0.5)
        
        return {
            "x": x.tolist(),
            "y": y.tolist(),
            "z": z.tolist(),
            "type": "surface",
            "colorscale": colorscale,
            "opacity": opacity,
            "showscale": True,
            "colorbar": {
                "title": "Resonance",
                "titleside": "right"
            },
            "lighting": {
                "ambient": 0.3,
                "diffuse": 0.8,
                "specular": 0.1
            }
        }

# ==================== MAIN ORION ENGINE ====================
class OrionEngine:
    """Main orchestrator for the Orion system"""
    
    def __init__(self, db_pool: asyncpg.Pool = None):
        self.db = db_pool
        self.session_manager = UserSessionManager(db_pool)
        self.toroidal_generator = ToroidalFieldGenerator()
        
        # System metrics
        self.metrics = {
            "j3_stability": 0.95,
            "rep_efficiency": 0.88,
            "active_sessions": 0,
            "total_seeds": 0,
            "consensus_rate": 0.85,
            "ghost_activations": 0,
            "uptime": datetime.utcnow()
        }
        
        # Periodic metrics update
        self._start_metrics_updater()
    
    def _start_metrics_updater(self):
        """Start background metrics updater"""
        async def update_metrics():
            while True:
                await asyncio.sleep(30)  # Update every 30 seconds
                self.metrics.update({
                    "j3_stability": np.random.uniform(0.85, 0.99),
                    "rep_efficiency": np.random.uniform(0.8, 0.96),
                    "active_sessions": len(self.session_manager.active_sessions),
                    "uptime": datetime.utcnow()
                })
                logger.debug("Updated system metrics")
        
        # Start in background if event loop exists
        try:
            asyncio.create_task(update_metrics())
        except RuntimeError:
            pass  # No event loop in this thread
    
    async def create_user_session(self, user_id: str) -> UserSession:
        """Create new user session"""
        session = await self.session_manager.create_session(user_id)
        self.metrics["active_sessions"] = len(self.session_manager.active_sessions)
        return session
    
    def get_system_metrics(self) -> Dict[str, Any]:
        """Get current system metrics"""
        return {
            **self.metrics,
            "uptime_seconds": (datetime.utcnow() - self.metrics["uptime"]).total_seconds()
        }
    
    def get_toroidal_field(self) -> Dict[str, Any]:
        """Generate current toroidal field visualization"""
        metrics = self.get_system_metrics()
        return self.toroidal_generator.generate(
            j3_stability=metrics["j3_stability"],
            rep_efficiency=metrics["rep_efficiency"],
            resonance=metrics.get("consensus_rate", 0.5)
        )

# ==================== EXPORTED SINGLETON ====================
_global_engine = None

def get_orion_engine(db_pool: asyncpg.Pool = None) -> OrionEngine:
    """Get singleton Orion engine instance"""
    global _global_engine
    if _global_engine is None:
        _global_engine = OrionEngine(db_pool)
    return _global_engine

# ==================== QUICK TEST ====================
async def test_engine():
    """Quick test of the engine"""
    engine = get_orion_engine()
    session = await engine.create_user_session("test_user")
    
    result = await session.process_input(
        "I want to build a bridge between consciousness and AI "
        "but I feel stuck in old patterns of thinking."
    )
    
    print("Test completed:")
    print(f"REP Efficiency: {result['rep_result']['efficiency_score']:.2%}")
    print(f"Consensus Confidence: {result['council_consensus']['confidence_score']:.2%}")
    print(f"Seed ID: {result['mycelial_seed_id'] or 'Not deposited'}")

if __name__ == "__main__":
    asyncio.run(test_engine())