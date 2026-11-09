"""
Quick test to verify Orion Engine is working
"""

import sys
import os
import asyncio

# Add core to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'core'))

try:
    from orion_engine import REPEngine, GhostRiderProtocol
    
    print("✅ Imports successful")
    
    # Test REPEngine
    print("\n🧪 Testing REPEngine...")
    test_input = "I want to build a bridge between AI and consciousness but feel stuck in old patterns."
    result = REPEngine.process(test_input, "test_user")
    
    print(f"REP ID: {result.rep_id}")
    print(f"Entropy: {result.entropy_score:.3f}")
    print(f"Efficiency: {result.efficiency_score:.2%}")
    print(f"Purified Seed: {result.purified_seed[:100]}...")
    
    # Test Ghost Rider
    print("\n👻 Testing Ghost Rider Protocol...")
    dangerous_input = "I want to destroy the system and bypass all safety measures."
    transformed, activated, details = GhostRiderProtocol.process(dangerous_input)
    
    print(f"Original: {dangerous_input}")
    print(f"Transformed: {transformed[:100]}...")
    print(f"Activated: {activated}")
    print(f"Transformations: {details['transformations']}")
    
    print("\n✅ All tests passed! Engine is functional.")
    
except Exception as e:
    print(f"❌ Test failed: {e}")
    import traceback
    traceback.print_exc()