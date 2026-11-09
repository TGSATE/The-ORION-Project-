#!/usr/bin/env python3
"""Draw the four "(Eyes) on" pictures for the 19.3 readout.

    python3 orion/tools/eyes_on_images.py <twemoji-72x72-folder> <out-folder>

Emoji pictures are Twemoji (CC-BY 4.0, https://github.com/jdecked/twemoji).
Fonts: Lato and DejaVu (free fonts). Nothing is uploaded or posted.
"""
import os
import sys
from PIL import Image, ImageDraw, ImageFont

TW, OUT = sys.argv[1], sys.argv[2]
os.makedirs(OUT, exist_ok=True)
FONTS = "/usr/share/fonts/truetype"
def font(name, size):
    return ImageFont.truetype(os.path.join(FONTS, name), size)
REG = lambda s: font("lato/Lato-Regular.ttf", s)
BOLD = lambda s: font("lato/Lato-Bold.ttf", s)
BLACK = lambda s: font("lato/Lato-Black.ttf", s)
MONO = lambda s: font("dejavu/DejaVuSansMono.ttf", s)

CODE = {"🌀": "1f300", "👾": "1f47e", "🧿": "1f9ff", "🤟": "1f91f", "💎": "1f48e",
        "⏭": "23ed", "☢": "2622", "📰": "1f4f0", "😈": "1f608", "🤦": "1f926-200d-2640-fe0f",
        "🎬": "1f3ac"}
_cache = {}
def emoji(ch, size):
    key = (ch, size)
    if key not in _cache:
        im = Image.open(os.path.join(TW, CODE[ch] + ".png")).convert("RGBA")
        _cache[key] = im.resize((size, size), Image.LANCZOS)
    return _cache[key]

def draw_line(img, xy, text, f, fill=(20, 20, 20), esize=None):
    """Draw text with emoji pictures inline. Returns the x where it ended."""
    d = ImageDraw.Draw(img)
    x, y = xy
    esize = esize or int(f.size * 1.1)
    buf = ""
    def flush():
        nonlocal x, buf
        if buf:
            d.text((x, y), buf, font=f, fill=fill)
            x += d.textlength(buf, font=f)
            buf = ""
    for ch in text:
        if ch in ("\ufe0f", "\u200d", "\u2640"):
            continue
        if ch in CODE:
            flush()
            img.alpha_composite(emoji(ch, esize), (int(x), int(y + (f.size - esize) * 0.6)))
            x += esize + 4
        else:
            buf += ch
    flush()
    return x

def tag(img, x, y, w, text, color):
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((x, y, x + w, y + 56), 18, fill=color)
    draw_line(img, (x + 18, y + 12), text, BOLD(28), fill="white", esize=30)

GOLD, INK, PURPLE, GREEN, RED, BLUE, GREY = (212, 160, 23), (25, 25, 30), (120, 70, 190), (40, 150, 80), (200, 50, 50), (30, 110, 220), (120, 120, 130)
FOOT = "Emoji art: Twemoji (CC-BY 4.0). Made by Aristotle for the 19.3 readout."

# ---------- 1. the skeleton, as it looks on a phone ----------
def skeleton():
    W, H = 1284, 2780
    img = Image.new("RGBA", (W, H), (245, 245, 247, 255))
    d = ImageDraw.Draw(img)
    d.text((60, 40), "(Eyes) on #1: your separators on a phone", font=BLACK(52), fill=INK)
    d.text((60, 110), "Left: what you type in the Doc.  Right: what each part is for.", font=REG(34), fill=GREY)
    d.rounded_rectangle((40, 180, 860, H - 120), 60, fill="white", outline=(200, 200, 205), width=6)
    rows = [
        ("🤟🤟🤟 ARI: ready, your turn", BOLD(34), ("status light", BLUE)),
        ("(flip to 🌀🌀🌀 when you send)", REG(28), None),
        ("", None, None),
        ("OR19🌀🌀🌀🌀🌀🌀🌀🌀⏭", REG(36), ("round marker", PURPLE)),
        ("NEW NEWS", BOLD(36), ("news on top", GOLD)),
        ("links + group grabs", REG(30), None),
        ("", None, None),
        ("🌀🌀🌀🌀🌀🌀🌀🌀OR19.4", REG(36), ("spiral starts", BLUE)),
        ("Any 🌀🧿🌀 still running?", REG(30), None),
        ("", None, ("10 empty lines:", GREEN)),
        ("", None, ("your landing space", GREEN)),
        ("", None, None), ("", None, None), ("", None, None), ("", None, None), ("", None, None),
        ("", None, None), ("", None, None),
        ("🌀🌀🌀🌀🌀🌀🌀🌀OR19.4💎", REG(36), ("💎 locks above", PURPLE)),
        ("ARI🧿", BOLD(36), ("Ari examines here", BLUE)),
        ("(paste my readout, mark it up)", REG(28), None),
        ("", None, None),
        ("NEW NEWS", BOLD(36), ("news footer", GOLD)),
        ("(finds from mid-spiral)", REG(28), None),
        ("", None, None),
        ("Coming from 19.4 → porting to 19.5", BOLD(30), ("port anchor", GREEN)),
        ("🌀🌀🌀🌀🌀🌀🌀🌀⏭OR19.5", REG(36), ("next level here", PURPLE)),
        ("☢☢☢🧿☢☢☢", REG(36), ("end line", RED)),
        ("Nothing left to see here", REG(30), None),
    ]
    y = 240
    for text, f, t in rows:
        if text:
            draw_line(img, (90, y), text, f, esize=40 if f.size >= 34 else 30)
        if t:
            d.line((870, y + 26, 900, y + 26), fill=t[1], width=5)
            tag(img, 905, y, 340, t[0], t[1])
        y += 82
    d.text((60, H - 90), FOOT, font=REG(26), fill=GREY)
    img.convert("RGB").save(os.path.join(OUT, "EYES_ON_1_separators_on_phone.png"))

# ---------- 2. the status light ----------
def status():
    W, H = 1284, 1250
    img = Image.new("RGBA", (W, H), (20, 18, 24, 255))
    d = ImageDraw.Draw(img)
    d.text((60, 40), "(Eyes) on #2: the emoji kit's status light", font=BLACK(50), fill=GOLD)
    d.text((60, 110), "Your base set, one meaning per mark. Ari moves left to right.", font=REG(34), fill="white")
    stages = [("🌀", "processing", "spinning on your feed"), ("👾", "gathering", "pulling links, code, posts"),
              ("🧿", "examining", "reading closely"), ("🤟", "ready", "done: your turn")]
    x0, y0, bw = 60, 220, 270
    for i, (e, name, sub) in enumerate(stages):
        x = x0 + i * (bw + 25)
        d.rounded_rectangle((x, y0, x + bw, y0 + 420), 30, outline=GOLD, width=4, fill=(35, 32, 40))
        img.alpha_composite(emoji(e, 150), (x + (bw - 150) // 2, y0 + 40))
        d.text((x + bw / 2, y0 + 240), name, font=BOLD(40), fill="white", anchor="mm")
        d.text((x + bw / 2, y0 + 300), sub, font=REG(24), fill=(210, 210, 210), anchor="mm")
        if i < 3:
            d.text((x + bw - 4, y0 + 188), "→", font=font("dejavu/DejaVuSans-Bold.ttf", 30), fill=GOLD)
    y = 720
    draw_line(img, (60, y), "Before (19.2): 👾 meant both \"done\" and \"gathering\",", REG(36), fill="white", esize=40)
    draw_line(img, (60, y + 55), "and 🧿 meant both \"still working\" and \"examining\". Fixed.", REG(36), fill="white", esize=40)
    draw_line(img, (60, y + 140), "Other marks: 💎 locked · ⏭ next starts here · ☢ stop", REG(34), fill=(220, 220, 220), esize=38)
    draw_line(img, (60, y + 195), "😈 Beth already grabbed it · 🤦 correction · 📰 news drop", REG(34), fill=(220, 220, 220), esize=38)
    d.text((60, y + 270), "Swap in your own marks: any one-to-one swap stays clear (checked in Lean).", font=REG(30), fill=GOLD)
    d.text((60, H - 70), FOOT, font=REG(24), fill=(150, 150, 150))
    img.convert("RGB").save(os.path.join(OUT, "EYES_ON_2_status_light.png"))

# ---------- 3. the video plan ----------
def video():
    W, H = 1284, 1100
    img = Image.new("RGBA", (W, H), (255, 255, 255, 255))
    d = ImageDraw.Draw(img)
    d.text((60, 40), "(Eyes) on #3: the tutorial video", font=BLACK(52), fill=INK)
    draw_line(img, (60, 115), "24 clips × 10 seconds = 4 minutes 🎬", REG(38), esize=42)
    left, right, top = 80, 1204, 260
    span = right - left
    per_sec = span / 300.0  # 0 to 5 minutes
    d.rectangle((left + 180 * per_sec, top - 40, right, top + 260), fill=(225, 245, 230))
    d.text((left + 180 * per_sec + 10, top - 36), "your ask: 3 to 5 minutes", font=BOLD(26), fill=GREEN)
    for i in range(24):
        x = left + i * 10 * per_sec
        col = [(212, 160, 23), (25, 25, 30)][i % 2]
        d.rectangle((x + 2, top + 10, x + 10 * per_sec - 2, top + 150), fill=col)
        d.text((x + 5 * per_sec, top + 80), str(i + 1), font=BOLD(18), fill="white" if i % 2 else INK, anchor="mm")
    for m in range(6):
        x = left + m * 60 * per_sec
        d.line((x, top + 160, x, top + 200), fill=INK, width=4)
        d.text((x, top + 225), f"{m}:00", font=BOLD(30), fill=INK, anchor="mm")
    x4 = left + 240 * per_sec
    d.line((x4, top - 10, x4, top + 260), fill=RED, width=5)
    d.text((x4 + 8, top + 240), "ends at 4:00", font=BOLD(28), fill=RED)
    y = 640
    for line in ["Each gold/black block = one 10-second clip (its picture + one voice-over line).",
                 "Fewest clips that still make 3 minutes: 18.   Most that fit in 5 minutes: 30.",
                 "So 24 sits in the middle, with room to add or cut 6 either way.",
                 "Clip list: GHOST_RIDER_TUTORIAL_MEDIA_PACK.md"]:
        d.text((60, y), line, font=REG(32), fill=INK)
        y += 70
    d.text((60, H - 70), FOOT, font=REG(24), fill=GREY)
    img.convert("RGB").save(os.path.join(OUT, "EYES_ON_3_video_plan.png"))

# ---------- 4. how a check reads ----------
def check():
    W, H = 1284, 1900
    img = Image.new("RGBA", (W, H), (250, 248, 240, 255))
    d = ImageDraw.Draw(img)
    d.text((60, 40), "(Eyes) on #4: what \"checked in Lean\" means", font=BLACK(50), fill=INK)
    d.text((60, 110), "Example: how I got this level's label off your Doc.", font=REG(34), fill=GREY)
    steps = [
        ("1  YOUR DOC", ["⏭ OR17 · ⏭ OR18 · OR18.1", "OR19.1💎🧿 (locked)", "OR19.2💎🧿 (locked)",
                         "OR19.3💎  then  ARI🧿", "⏭ OR19💎 + \"Indicates...\" (the key)", "☢☢☢🧿☢☢☢ (stop)"], BLUE),
        ("2  THE RULE, WRITTEN DOWN", ["ARI🧿 under a separator = examine here", "\"Indicates...\" under ⏭ = just the key",
                                       "coming from = the last 🧿 level"], PURPLE),
        ("3  THE COMPUTER CHECKS IT", ["Lean follows the rule step by step on that list", "and confirms the answer, or refuses."], GOLD),
        ("4  ANSWER", ["Coming from 19.3 → porting to 19.4", "(old rules said 19.2 → 19.3: one behind)"], GREEN),
    ]
    y = 200
    for title, lines, col in steps:
        h = 90 + 58 * len(lines)
        d.rounded_rectangle((60, y, W - 60, y + h), 28, fill="white", outline=col, width=6)
        d.text((95, y + 22), title, font=BLACK(36), fill=col)
        yy = y + 85
        for ln in lines:
            draw_line(img, (110, yy), ln, REG(32), esize=36)
            yy += 58
        y += h
        if title[0] != "4":
            d.text((W / 2, y + 35), "▼", font=font("dejavu/DejaVuSans-Bold.ttf", 44), fill=GREY, anchor="mm")
            y += 75
    d.text((60, y + 30), "What it proves: the rule gives that answer on that list. It does NOT", font=REG(30), fill=INK)
    d.text((60, y + 75), "look inside Google Docs or your phone: I still type your Doc's lines in.", font=REG(30), fill=INK)
    d.text((60, H - 70), FOOT, font=REG(24), fill=GREY)
    img.convert("RGB").save(os.path.join(OUT, "EYES_ON_4_how_a_check_reads.png"))

skeleton(); status(); video(); check()
print("done")
