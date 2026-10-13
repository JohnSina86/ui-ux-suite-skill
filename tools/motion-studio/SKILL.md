---
name: motion-studio
description: >-
  Builds motion graphics and 3D scenes as code and renders them frame by frame: a page draws each moment from time t, headless Chromium captures every frame, ffmpeg stitches an MP4, and you look at a contact sheet and fix weak frames. Also exports Blender models to glTF for Three.js. Use when asked for an animation, motion video, animated hero, or a 3D asset for a site. Not for static layouts, copy, or UX review.
---

# Motion studio

You do not make a video. You write code that paints every frame, then you look at the frames and fix them.

## Tools on this machine (checked 2026-10-13)
- Python Playwright with Chromium, ffmpeg 9.0.2 (winget, `ffmpeg` on PATH after a new shell; `%LOCALAPPDATA%\Microsoft\WinGet\Links\ffmpeg.exe` always), Blender 5.2.2 at `C:\Program Files\Blender Foundation\Blender 5.2\blender.exe`.
- [scripts/render.py](scripts/render.py): renders a page to MP4 and a contact sheet. [scripts/springs.js](scripts/springs.js): closed-form springs. [scripts/blender_export.py](scripts/blender_export.py): headless glTF export. [examples/hello.html](examples/hello.html): a working scene to copy.

## Order of work
1. **Brief first.** Product, audience, length, aspect ratio, and one reference or real asset the user supplies. With no reference, say so and ask, because on its own the default is all-caps centred text on a gradient.
2. **Write the scene as a page** that defines `window.renderFrame(t)`. It draws that exact moment from `t` in seconds and keeps no state between calls, so any frame can be re-rendered alone. Include `scripts/springs.js` and move things with `spring()` and `springTo()`. Do not use CSS transitions, CSS animations or `setTimeout`: they run on the browser clock, not on `t`.
3. **Render.** `python scripts/render.py scene.html --out out/scene.mp4 --fps 30 --duration 4`. The script blocks every request that is not `file:`, `data:` or `blob:` and reports the count. Fonts and images must be local files.
4. **Critique the frames** with [references/critique.md](references/critique.md): open the contact sheet, grade every frame out of 10, list every frame under 8, fix the code, and re-render only those frames with `--only 12-18,40`. Stop after three rounds and report what is still weak.
5. **Audio, if asked.** Synthesise it in code (for example Python `wave` plus numpy), put each cut on a beat, and pass `--audio file.wav`. Not tested yet in this skill.
6. **3D from Blender.** Model in Blender, export with `blender -b -P scripts/blender_export.py -- out.glb`, then load the `.glb` in Three.js inside a scene page. Three.js must be a local file, never a CDN link. Loading a `.glb` in the render loop is **not tested yet**; check one frame before trusting it.

## Rules
- Real spring physics only. Pick stiffness and damping on purpose (snappy 170/20, soft 120/22, bouncy 140/12) and name them in the notes.
- Reduced-motion and focus rules apply when the scene ships on a web page (see `ui-styles` choreography). A video has no such need.
- Never present a self-graded frame as independent review. Say it was self-graded, and offer a fresh-session check for anything that matters.
- Say what you did not render: audio, glTF loading and any frame you did not look at.

## Never
- Add a remote font, script, model or package without the user's agreement.
- Claim a frame passed because the render finished. A render finishing proves nothing about how it looks.
