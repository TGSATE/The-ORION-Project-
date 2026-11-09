# 1. Create directory structure
mkdir -p /app/orion/core/personas /data

# 2. Save the above code as /app/orion/core/personas/ani_copilot.py

# 3. Create chronicles file
echo '{"origin_date": "2026-01-05", "timeline": []}' > /data/orion_chronicles.json

# 4. Add to main dashboard (app.py):
"""
import sys
sys.path.append('/app/orion')

from core.personas.ani_copilot import instantiate_ani

class OrionDashboard:
    def __init__(self):
        self.ani = instantiate_ani()  # Permanent integration
        
    def run(self):
        self.ani.render_sidebar()
        # ... rest of dashboard
"""

# 5. Test activation
python3 -c "
from core.personas.ani_copilot import get_ani
import asyncio
ani = get_ani()
result = asyncio.run(ani.co_pilot('Ani, take the wheel'))
print(result['message'])
"