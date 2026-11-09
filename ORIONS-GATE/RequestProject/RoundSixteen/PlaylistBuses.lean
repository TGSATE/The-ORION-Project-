module
public import Mathlib

/-!
# Round 16: Spotify ↔ YouTube playlist alignment and the three energy buses

Data are the **saved snapshots** in `orion/r16/` (YouTube, 7 October 2026) and the Spotify
playlist snapshot (57 tracks, unchanged since `orion/r14/SPOTIFY_PLAYLIST_57.json`).
The pairing below was made by hand by matching song titles and artists; a pair means
"the same song", even where the version differs (Spotify 50 is the acoustic *This Place*,
YouTube 20 the official video).

The checks only concern these finite lists, not the live pages.
-/

@[expose] public section

namespace RoundSixteen.Playlists

/-- `(Spotify position, YouTube position)` for every song found on both playlists. -/
def pairs : List (ℕ × ℕ) :=
  [(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),
   (14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,21),(21,22),(22,23),(23,24),(24,25),
   (25,26),(26,27),(27,30),(28,29),(29,31),(30,32),(31,28),(32,33),(33,34),(34,35),(35,36),
   (36,38),(37,39),(38,40),(39,41),(40,42),(41,43),(42,44),(43,46),(44,48),(45,49),(46,50),
   (47,53),(48,54),(49,59),(50,20),(51,45),(52,57),(53,58),(54,60),(55,61),(56,62)]

/-- Number of tracks on the Spotify snapshot. -/
def spotifyCount : ℕ := 57
/-- Number of videos on the YouTube music playlist snapshot. -/
def youtubeCount : ℕ := 62

/-- Spotify positions with no YouTube partner. -/
def spotifyOnly : List ℕ := (List.range' 1 spotifyCount).filter (fun i => i ∉ pairs.map Prod.fst)
/-- YouTube positions with no Spotify partner. -/
def youtubeOnly : List ℕ := (List.range' 1 youtubeCount).filter (fun j => j ∉ pairs.map Prod.snd)

/-- The pairing is one-to-one on both sides, stays inside both lists, and covers 56 songs;
exactly one Spotify track (57, *Living in the Future*) is missing from YouTube, and six
YouTube videos (37, 47, 51, 52, 55, 56) are not on Spotify. -/
theorem playlist_alignment :
    pairs.length = 56 ∧ (pairs.map Prod.fst).Nodup ∧ (pairs.map Prod.snd).Nodup ∧
    (∀ p ∈ pairs, 1 ≤ p.1 ∧ p.1 ≤ spotifyCount ∧ 1 ≤ p.2 ∧ p.2 ≤ youtubeCount) ∧
    spotifyOnly = [57] ∧ youtubeOnly = [37, 47, 51, 52, 55, 56] ∧
    pairs.length + spotifyOnly.length = spotifyCount ∧
    pairs.length + youtubeOnly.length = youtubeCount := by
  decide

/-- The three proposed energy buses. -/
inductive Bus | kronos | krion | orion
  deriving DecidableEq, Fintype

/-- However songs are sorted onto the three buses (one bus per song), the bus counts add up
to the whole playlist: no song is lost or counted twice. -/
theorem bus_counts_add_up {Song : Type*} (songs : Finset Song) (bus : Song → Bus) :
    (songs.filter (bus · = .kronos)).card + (songs.filter (bus · = .krion)).card +
      (songs.filter (bus · = .orion)).card = songs.card := by
  classical
  induction songs using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
    rw [Finset.card_insert_of_notMem ha, ← ih]
    cases hb : bus a <;>
      simp [Finset.filter_insert, hb, Finset.card_insert_of_notMem, ha] <;> omega

end RoundSixteen.Playlists
