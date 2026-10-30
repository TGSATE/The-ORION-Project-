-- Postgres/Redis hybrid model
SEEDS {
  seed_id: PRIMARY_KEY,
  original_hash: UNIQUE_INDEX,
  resonance_vector: VECTOR(1536), -- For semantic matching
  j3_status: BIT(3),
  collaborators: ARRAY[USER_ID],
  created_at: TIMESTAMP,
  last_accessed: TIMESTAMP,
  trajectory_count: INT
}

USER_RESONANCE {
  user_id: PRIMARY_KEY,
  frequency_profile: VECTOR(768),
  expertise_tags: ARRAY[TEXT],
  contributed_seeds: ARRAY[SEED_ID],
  reputation_score: FLOAT
}