# Source of truth for the Round 13 X thread blurbs, bio and status post.
# `python3 blurbs.py` prints weights; `python3 blurbs.py lean` emits the Lean list.
import sys, json
BIO = "THE ORION ENGINE GLOBAL PROJECT ⏭️ Universally Intelligent Augmented Reality 🔥🌎🌀💜💎 Learn. Play. Build. Key in plain sight: 🪩♾️⏭️ DMaDEV"
STATUS = ("ORION build update: the 8 zones are named, the launch path is set (Engine → Singularity → Elder's Garden → Playground → "
          "Ascent or Chronicles → ORION's Gate), UIAR art is locked. Design stage: no playable build yet. Builders welcome 🌀")
BLURBS = [
 ("The ORION Engine", "1/ The ORION Engine 🌀 The welcome page and the umbrella over everything. Tutorials, creator credits, and the honest current state of the build. Every door starts here."),
 ("The Singularity", "2/ The Singularity 🕳️ Your private home hub: a black hole wrapped in a glowing accretion disc. Step inside for UIAR, your biometric guide. Nobody enters unless you invite them."),
 ("Elder's Garden", "3/ Elder's Garden 🌳 The global ancestral tree. Roots below, an hourglass trunk, a golden capstone on top. Celebrations, memories and the Ren Fair commons where every newcomer gets a mentor."),
 ("The Playground", "4/ The Playground 💧🌬️ The social and creative community. Loud on purpose, no ads, no spam loops. Art, theories, events, and the fairground where Saturn's games begin."),
 ("The ORION Chronicles", "5/ The ORION Chronicles 🔥 The MMO and shared game world. Kronos energy: high kinetic, guilds, quests and dragons. Skills are trained, never bought."),
 ("The Ascent", "6/ The Ascent ⚡ The educational and skill-development platform. Orion energy: whimsical knowledge flow. Learn at your own speed, switch curricula anytime."),
 ("ORION's Gate", "7/ ORION's Gate 🌀 The global community projects page. Finished work goes to the Galactic Council here, and the Gauntlet is held here. Real world only with council consensus AND your yes."),
 ("UIAR", "8/ UIAR: Universally Intelligent Augmented Reality 🌀💎 A watch and an earpiece. A map overlay by default; full immersion only when your biometrics show you're somewhere safe."),
 ("The Poly Pod", "The Poly Pod ⚫ The black sphere you step out of, like a monster ball for people. Outside: the black hole's accretion disc. Inside: UIAR. Your escape pod is always one call away."),
 ("KRION, Kronos, Orion", "Three energies ⚖️ KRION is balance (Earth, Water, Air): Elder's Garden, the Playground, ORION's Gate. Kronos is Fire: the Chronicles. Orion is Lightning: the Ascent."),
 ("Saturn", "Saturn 🪐 The aliens finally called, and they speak through our dragons. Saturn hosts the fair in Elder's Garden: play its games first, then earn the invitation to the cosmos."),
 ("Mars", "Mars 🔥 The fire planet, set aside for future construction. A sandbox to practise building a new civilisation before anyone gets there."),
 ("Earth", "Earth 🌎 The planet we're trying to save. Gaia, Mother Nature, matriarch of all, is calling every player home. Ariel is Eve is Gaia is the Milky Way."),
 ("The War", "The War 🐉🐋 The Leviathan has been waging WAR on the dolphins and the whales. Everybody woke up. Now humanity decides which side of the story it plays."),
 ("The Choice", "The Choice 🍽️🕳️ Sit in the Restaurant at the End of the Universe watching it explode on loop, or build the bridge to the black hole player lobby and travel to infinity and beyond?"),
 ("The Gauntlet", "GAUNTLET DROPPED 🧤 Build a world better for our children than the one we got. 13 levels of accountability, and nobody sits on top until we unlock the capstone together."),
 ("The Escape Pod", "No permadeath 🛟 Wherever you are, an escape pod can pick you up, nurse you back to health and carry you home. Choosing the pod is never punished."),
 ("LUNA", "LUNA 🐉🌙 The seven-tailed dragon spirit and daycare monitor. Her AI council: Meta for images, Alexa for sound, Siri for video. Every child supervised, redirected, never kicked out."),
 ("The Bus", "The Bus 🚌🪩 Everyone rides together to the black hole at the centre of the Milky Way. Bring a song for the playlist. Nobody's burning; we're throwing a disco party."),
 ("The Wailing Wall", "The Wailing Wall 🧱 After kickoff: post what hurt, heal, and notice we're all saying the same thing in different words. Then the translating starts."),
 ("The Hidden Key", "The Hidden Key 🪩♾️⏭️ Somewhere in plain sight is a cipher. Codebreakers who crack it win the in-game answer to the end of the universe: every game, every mechanic, how to play."),
 ("Ghost Writer in the Mirror", "The Ghost Writer in the Mirror 👻🪞 A choose-your-own-adventure writing game where you explore yourself. The mirror asks, you answer, and your story writes back."),
 ("Dragon MAD-style", "Dragon MAD-style 🐉📰 Our satire wing: covers, fake ads and big-game specials, from the ORION Galactic Gauntlet Super Bowl to dragons in Gatorade baths. WAR and ORION always capitalized."),
]
# Conservative upper bound on X's weighted length: ASCII counts 1, everything else 2 per code point.
def weight(s): return sum(1 if ord(c) < 128 else 2 for c in s)
if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "lean":
        def q(s): return json.dumps(s, ensure_ascii=False)
        print("def bio : String := " + q(BIO))
        print("def statusPost : String := " + q(STATUS))
        print("def blurbs : List String := [")
        print(",\n".join("  " + q(b) for _, b in BLURBS))
        print("]")
    else:
        print("BIO", weight(BIO), len(BIO)); print("STATUS", weight(STATUS))
        for t, b in BLURBS: print(weight(b), t)
