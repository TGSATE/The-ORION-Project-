-- Orion Chronicles Database Schema
-- PostgreSQL 14+ Recommended

-- ==================== USERS & SESSIONS ====================
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    resonance_frequency FLOAT DEFAULT 0.5,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_active TIMESTAMPTZ DEFAULT NOW(),
    player_stats JSONB DEFAULT '{}'
);

CREATE TABLE user_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    ended_at TIMESTAMPTZ,
    activity_log JSONB DEFAULT '[]',
    council_debates JSONB DEFAULT '[]',
    INDEX idx_user_sessions (user_id, created_at DESC)
);

-- ==================== REP PROCESSING ====================
CREATE TABLE rep_processes (
    rep_id VARCHAR(50) PRIMARY KEY,
    session_id UUID REFERENCES user_sessions(session_id),
    raw_input TEXT,
    purified_seed TEXT,
    entropy_score FLOAT,
    rind_mass FLOAT,
    efficiency_score FLOAT,
    j3_applied JSONB,
    ghost_rider_activated BOOLEAN DEFAULT FALSE,
    processed_at TIMESTAMPTZ DEFAULT NOW(),
    INDEX idx_rep_efficiency (efficiency_score DESC),
    INDEX idx_rep_timestamp (processed_at DESC)
);

-- ==================== MYCELIAL SEEDS ====================
CREATE TABLE mycelial_seeds (
    seed_id VARCHAR(50) PRIMARY KEY,
    origin_user_id UUID REFERENCES users(user_id),
    original_content TEXT,
    purified_seed TEXT NOT NULL,
    rep_id VARCHAR(50) REFERENCES rep_processes(rep_id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    j3_completion JSONB DEFAULT '{"epigenetic": false, "neurological": false, "quantum": false}',
    collaborators UUID[] DEFAULT ARRAY[]::UUID[],
    resonance_score FLOAT DEFAULT 0.0,
    trajectory_branches JSONB DEFAULT '[]',
    is_harvested BOOLEAN DEFAULT FALSE,
    harvested_at TIMESTAMPTZ,
    -- Vector embedding for semantic search (pgvector extension)
    seed_embedding VECTOR(1536),
    INDEX idx_seed_resonance (resonance_score DESC),
    INDEX idx_seed_harvested (is_harvested, created_at DESC),
    INDEX idx_seed_collaborators USING GIN (collaborators)
);

-- ==================== COLLABORATIONS ====================
CREATE TABLE seed_collaborations (
    collaboration_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seed_id VARCHAR(50) REFERENCES mycelial_seeds(seed_id),
    user_id UUID REFERENCES users(user_id),
    torque_type VARCHAR(20) CHECK (torque_type IN ('epigenetic', 'neurological', 'quantum')),
    contribution TEXT NOT NULL,
    contributed_at TIMESTAMPTZ DEFAULT NOW(),
    resonance_impact FLOAT,
    INDEX idx_seed_collaborations (seed_id, contributed_at DESC)
);

-- ==================== COUNCIL DEBATES ====================
CREATE TABLE council_debates (
    debate_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES user_sessions(session_id),
    rep_id VARCHAR(50) REFERENCES rep_processes(rep_id),
    consensus TEXT,
    individual_responses JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    duration_ms INTEGER,
    INDEX idx_debate_timestamp (created_at DESC)
);

-- ==================== SYSTEM METRICS ====================
CREATE TABLE system_metrics (
    metric_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    metric_time TIMESTAMPTZ DEFAULT NOW(),
    j3_stability FLOAT,
    rep_efficiency FLOAT,
    active_users INTEGER,
    seeds_planted INTEGER,
    consensus_rate FLOAT,
    toroidal_field_data JSONB
);

-- ==================== GHOST RIDER LOGS ====================
CREATE TABLE ghost_rider_logs (
    log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id),
    original_input TEXT,
    transformed_input TEXT,
    detected_patterns TEXT[],
    transformed_at TIMESTAMPTZ DEFAULT NOW(),
    INDEX idx_ghost_rider_time (transformed_at DESC)
);

-- ==================== VECTOR SEARCH EXTENSION ====================
-- Install pgvector extension first
-- CREATE EXTENSION IF NOT EXISTS vector;

-- Create HNSW index for fast similarity search
CREATE INDEX idx_seed_embeddings 
ON mycelial_seeds 
USING hnsw (seed_embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);

-- ==================== MATERIALIZED VIEWS ====================
CREATE MATERIALIZED VIEW user_leaderboard AS
SELECT 
    u.user_id,
    u.username,
    COUNT(DISTINCT ms.seed_id) as seeds_planted,
    COUNT(DISTINCT sc.collaboration_id) as collaborations,
    COALESCE(AVG(ms.resonance_score), 0) as avg_resonance,
    COALESCE(AVG(rp.efficiency_score), 0) as avg_efficiency
FROM users u
LEFT JOIN mycelial_seeds ms ON u.user_id = ms.origin_user_id
LEFT JOIN seed_collaborations sc ON u.user_id = sc.user_id
LEFT JOIN rep_processes rp ON u.user_id = (
    SELECT us.user_id 
    FROM user_sessions us 
    WHERE us.session_id = rp.session_id
    LIMIT 1
)
GROUP BY u.user_id, u.username
ORDER BY seeds_planted DESC, avg_resonance DESC;

-- Refresh view periodically
-- CREATE OR REPLACE FUNCTION refresh_leaderboard()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     REFRESH MATERIALIZED VIEW CONCURRENTLY user_leaderboard;
--     RETURN NULL;
-- END;
-- $$ LANGUAGE plpgsql;

-- ==================== FUNCTIONS ====================
CREATE OR REPLACE FUNCTION calculate_user_resonance(user_uuid UUID)
RETURNS FLOAT AS $$
DECLARE
    avg_resonance FLOAT;
BEGIN
    SELECT AVG(resonance_score) INTO avg_resonance
    FROM mycelial_seeds
    WHERE origin_user_id = user_uuid;
    
    RETURN COALESCE(avg_resonance, 0.5);
END;
$$ LANGUAGE plpgsql;