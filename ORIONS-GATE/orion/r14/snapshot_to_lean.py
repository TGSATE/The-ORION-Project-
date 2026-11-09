"""Generate Lean assertions about captured album-index and playlist metadata.

The result checks the finite snapshot, not the live websites, their authors, or licenses.
"""
import csv, json
from pathlib import Path

base = Path(__file__).resolve().parent
album = list(csv.DictReader((base / 'ALBUM_INDEX_1333.tsv').open(), delimiter='\t'))
tracks = json.loads((base / 'SPOTIFY_PLAYLIST_57.json').read_text())['trackList']

def bool_list(vals):
    vals = ['true' if v else 'false' for v in vals]
    return '\n    ' + ',\n    '.join(', '.join(vals[i:i + 30]) for i in range(0, len(vals), 30)) + '\n'

def int_list(vals):
    return '\n    ' + ',\n    '.join(', '.join(map(str, vals[i:i + 12])) for i in range(0, len(vals), 12)) + '\n'

file = base.parent.parent / 'RequestProject' / 'RoundFourteen' / 'SnapshotCounts.lean'
file.write_text('''module
public import Mathlib

/-!
# Round 14 captured metadata arithmetic

Generated from `orion/r14/ALBUM_INDEX_1333.tsv` and
`orion/r14/SPOTIFY_PLAYLIST_57.json`. A snapshot is **not** proof of a live site's
current state or of media ownership, origin, listening content or game permissions.
The user-visible numbers below are finite computations over copied metadata.
-/
namespace RoundFourteen.Snapshot

public def previouslyIndexed : List Bool := [''' + bool_list(r['status'] == 'seen_R12' for r in album) + ''']
public def isNewVideo : List Bool := [''' + bool_list(r['status'] == 'new_R14' and r['kind'] == 'video' for r in album) + ''']
public def spotifyExplicit : List Bool := [''' + bool_list(t['isExplicit'] for t in tracks) + ''']
public def spotifyDurationsMs : List ℕ := [''' + int_list([t['duration'] for t in tracks]) + ''']

/-- The copied album index contains 1,333 records, 300 already indexed and 1,033 new,
including 12 newly indexed videos. -/
public theorem album_snapshot_counts :
    previouslyIndexed.length = 1333 ∧
    previouslyIndexed.count true = 300 ∧
    previouslyIndexed.count false = 1033 ∧
    isNewVideo.count true = 12 := by
  decide +kernel

/-- The copied playlist metadata contains 57 items, 13 marked explicit by Spotify. -/
public theorem playlist_snapshot_counts :
    spotifyExplicit.length = 57 ∧ spotifyExplicit.count true = 13 ∧
    spotifyDurationsMs.length = 57 ∧
    206 * 60 * 1000 ≤ (spotifyDurationsMs : List ℕ).sum ∧
    (spotifyDurationsMs : List ℕ).sum < 207 * 60 * 1000 := by
  decide +kernel

end RoundFourteen.Snapshot
''')
print(file)
