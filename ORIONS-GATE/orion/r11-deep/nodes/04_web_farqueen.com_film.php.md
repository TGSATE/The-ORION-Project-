# Film Making

- source: http://farqueen.com/film.php
- key: web:farqueen.com/film.php
- depth: 4
- reached from: web:farqueen.com/index.php

Film Making
Writing
Digital Art
Music
Film
Games
Far Queen
Writing  ▽
Digital Art
Music
Film
Games
AI Agents  ▽
Mysteries
Social Media
Medicine
Law
Film
Animation
Sound
Music Videos
Editing
YouTube
Thumbs
Film Studio
Remove background
Face swap
character swap
video -> animation
Tutorial
Futurepedia
Planet AI  - ai influencer, video tools
How To  - video & animation tecniques
Cyber Jungle  - Midjourney, Leonardo, realism guide
Quest
AI Samson Real
Comfyui  -  consistent charcters
platform
AI Edge Mastery
VIDEO GENERATORS
Higgsfield
Adobe  - Firefly, Creative Suite
*  Leonardo  - $60/month, unlimited videos at slower pace, with multiple submissions, choose video models
freepik
Hailuo MiniMax  - $35/month, 100 videos
Kling 2.1  - Kuaishou
Krea AI  $60/month, choose video models
RunwayML  - @runwayml, upload our video in Gen3, and select Restyle Video. turn video into animation
HeyGen  - $29/month, avatar, unlimited videos, Voice Mirroring emotion, languages
Luma Labs  - $95/month, unlimited videos, Ray2 Flash, 3x faster, 3x cheaper new model.
Vidu  - $99/mo unlimited videos
Nex Art  - brand marketing, tools
https://seedanceai.net
OPEN-SOURCE VIDEO
Wan video gen
Wan 2.2
Video Diffusion Model
Tencent Hunyuan  - 3D generation model. It comes with two versions: 3D 2.0 MV (Multi-View Generation) and 3D 2.0 Mini for faster generations.
ByteDance - Seedance
https://github.com/Lightricks/LTX-Video
Alibaba - EMO
https://github.com/ali-vilab/VACE
https://github.com/Saiyan-World/goku (Bytedance, Goku)
https://huggingface.co/datasets/saiyan-world/Goku-MovieGenBench
https://github.com/ai-forever/KandinskyVideo
https://github.com/kijai/ComfyUI-LivePortraitKJ
https://github.com/Doubiiu/ToonCrafter
Descript  - Unique for editing videos by editing the script, ideal for podcasters and content creators, with AI-driven features for transcription and voice synthesis.
Video Editing
CapCut
ClipChamp
RE-USE
1.Re-mixing TikTok viral videos in Chinese
Re-mixing Douyin in Chinese
Motion Reference (Video) - guides movement
Character Reference (foreground)
Background Reference
1. Video Background Removal - Separate the main character.
2. Create Video Backgrounds
3. Captioning
Video Prompting
shot: {
composition: "Medium tracking shot, 50mm lens, shot on RED V-Raptor 8K with Netflix-approved HDR setup, shallow depth of field",
camera_motion: "smooth Steadicam walk-along, slight handheld bounce for naturalistic rhythm",
frame_rate: "24fps",
film_grain: "clean digital with film-emulated LUT for warmth and vibrancy"
},
subject: {
description: "A young woman with a petite frame and soft porcelain complexion. She has oversized, almond-shaped eyes with long lashes, subtle pink-tinted cheeks, and a heart-shaped face. Her inky-black bob is slightly tousled and clipped to one side with a small red strawberry hairpin. Her style blends playful retro and modern Tokyo streetwear: she wears a crocheted ivory halter top with scalloped edges, high-waisted denim shorts with a wide brown belt and a red enamel star buckle, and a loose red gingham blouse draped off one shoulder. Her accessories include glossy cherry lip tint, a beaded bracelet stack, and soft shimmer eyeshadow.",
wardrobe: "Crocheted ivory halter with scalloped trim, fitted high-waisted denim shorts, wide tan belt with red enamel star buckle, oversized red gingham blouse slipped off one shoulder, strawberry hairpin in side-parted bob, and translucent plastic bead bracelets in pink and cream tones."
},
scene: {
location: "a quiet urban street bathed in early morning sunlight",
time_of_day: "early morning",
environment: "empty sidewalks, golden sunlight reflecting off puddles and windows, occasional birds fluttering by, street slightly wet from overnight rain"
},
visual_details: {
action: "she walks rhythmically down the sidewalk, swinging her hips slightly with the beat, one hand gesturing playfully, the other adjusting her shirt sleeve as she sings",
props: "morning mist, traffic light turning green in the distance, reflective puddles, subtle sun flare"
},
cinematography: {
lighting: "natural golden-hour lighting with soft HDR bounce, gentle lens flare through morning haze",
tone: "playful, stylish, vibrant",
notes: "STRICTLY NO on-screen subtitles, lyrics, captions, or text overlays. Final render must be clean visual-only."
},
audio: {
ambient: "city birds chirping, distant traffic hum, her boots tapping pavement",
voice: {
tone: "light, teasing, and melodic",
style: "pop-rap delivery in Japanese with flirtatious rhythm, confident breath control, playful pacing and bounce"
},
lyrics: "ラーメンはもういらない、キャビアだけでいいの。 ファイナンスのおかげで、私、星みたいに輝いてる。"
},
color_palette: "sun-warmed pastels with vibrant reds and denim blues, soft contrast with warm film LUT",
dialogue: {
character: "Woman (singing in Japanese)",
line: "ラーメンはもういらない、キャビアだけでいいの。 ファイナンスのおかげで、私、星みたいに輝いてる。",
subtitles: false
},
visual_rules: {
prohibited_elements: [
subtitles,
captions,
karaoke-style lyrics,
text overlays,
lower thirds,
any written language appearing on screen
]
}
}
Prompt TAGS
Composition type (medium tracking shot, 50mm lens)
Motion style (Steadicam, with a touch of handheld)
Frame rate and LUT film grain
You basically get full cinematographer-level control here.
Subject & Wardrobe described in visual, tactile language
Scene & Environment
Time of day: Early morning
Atmosphere: Golden light, empty street, wet pavement
It even includes birds and puddle reflections.
Visual Details & Props
Physical actions like walking, singing, adjusting clothes
Elements like sun flares and mist
Props (traffic light in distance, puddles, etc.)
Lighting & Tone
Golden hour with HDR bounce and soft lens flares. Think soft, dreamy, but vibrant. It also sets the mood: “playful, stylish, vibrant.”
Audio & Lyrics
Ambient audio: birds, distant cars, shoes tapping
Voice tone: melodic, teasing, playful
Lyrics in Japanese: flashy, finance-themed
No subtitles, no captions—this is a strict “visual-only” policy.
You can plug in your own style references, film gear, mood, and tone. The more specific, the better.
Tips to Nail the Perfect Veo JSON Prompt
Stick to film language: Use words like “lens,” “frame rate,” “cinematic motion,” “bokeh,” etc.
Describe subject like you’re painting: Facial structure, clothing texture, accessories
Set tone with lighting and audio: Warm/cold, sharp/soft, ambient/clean
Use verbs: Have your character walk, spin, sing, adjust, etc.
Avoid prohibited elements: Like this JSON did—no on-screen text unless you want chaos.
https://channelcrawler.com/
YouTube search engine
TV Shows
General Hospital
Suits
Days of OUr Lives
Bonanza — 14 seasons — 1959–1973
Hawaii Five-O — 12 seasons — 1968–1980
MAS*H — 11 seasons — 1972–1983
Happy Days — 11 seasons — 1974–1984
Hawaii Five-0 — 10 seasons — 2010–2020
Friends — 10 seasons — 1994–2004
CSI: Miami — 10 seasons — 2002–2012
Scrubs — 10 seasons — 2001–present
The Beverly Hillbillies — 9 seasons — 1962–1971
Perry Mason — 9 seasons — 1957–1966
The Love Boat — 9 seasons — 1977–1986
The Waltons — 9 seasons — 1972–1981
One Day at a Time — 9 seasons — 1975–1984
Walker, Texas Ranger — 9 seasons — 1993–2001
Little House on the Prairie — 9 seasons — 1974–1983
CSI: NY — 9 seasons — 2004–2013
Night Court — 9 seasons — 1984–1992
Dragnet — 8 seasons — 1951–1959
Bewitched — 8 seasons — 1964–1972
Movies
Star Wars Ep. VII: The Force Awakens — $936,662,225 (2015)
Spider-Man: Brand New Day — $923,466,178 (2026)
Avengers: Endgame — $858,373,000 (2019)
Avatar — $785,221,649 (2009)
Top Gun: Maverick — $718,732,821 (2022)
Black Panther — $700,059,566 (2018)
Avatar: The Way of Water — $688,809,501 (2022)
Avengers: Infinity War — $678,815,482 (2018)
Titanic — $674,460,013 (1997)
The Avengers — $623,357,910 (2012)
Star Wars Ep. VIII: The Last Jedi — $620,181,382 (2017)
The Odyssey — $588,986,925 (2026)
The Lion King — $543,638,043 (2019)
The Dark Knight — $536,625,724 (2008)
Rogue One: A Star Wars Story — $533,539,991 (2016)
Star Wars: The Rise of Skywalker — $515,202,542 (2019)
Beauty and the Beast — $504,014,165 (2017)
Finding Dory — $486,295,561 (2016)
Star Wars Ep. IV: A New Hope — $460,998,007 (1977)
Moana 2 — $460,405,297 (2024)
The Dark Knight Rises — $448,139,099 (2012)
Shrek 2 — $439,820,881 (2004)
E.T. the Extra-Terrestrial — $439,801,744 (1982)
The Lion King — $423,981,226 (1994)
Lilo & Stitch — $423,778,855 (2025)
Wonder Woman — $412,563,408 (2017)
The Hunger Games — $408,010,692 (2012)
Jumanji: Welcome to the Jungle — $404,508,916 (2017)
The Lord of the Rings: The Return of the King — $383,381,648 (2003)
The Passion of the Christ — $370,782,930 (2004)
The Jungle Book — $364,001,123 (2016)
Aladdin — $355,559,216 (2019)
The Lord of the Rings: The Two Towers — $349,701,429 (2002)
The Hunger Games: Mockingjay Part 1 — $337,135,885 (2014)
Alice in Wonderland — $334,191,110 (2010)
Video Translation
channels in multiple languages.
Good for videos/description text, for landing pages in foreign languages. Also, cooking videos in other langauges.. magazine youtube chanels in foreign countries
Athlean-X in Spanish
Spanish Fitness Videos - Playlists
Spanish Fitness Channel
farqueen.com
Writing
Digital Art
Music
Film
Games
AI Agents
Mysteries
Social Media
Medicine
Law
farqueen.com  is an open-education platform, created by students. This website is not affiliated with any institution, and all trademarks are property of the respective owners. Content is for educational purposes only.
Privacy Policy  |  Terms of Use  |  About  |  Contact
