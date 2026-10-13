#!/usr/bin/env python3
"""Deterministic frame renderer.

A page exposes window.renderFrame(t) (t in seconds) that draws that exact moment and nothing else.
This script opens the page in headless Chromium, calls renderFrame for every frame, saves a PNG,
and stitches the frames into an MP4 with ffmpeg. It also writes a contact sheet for the critique step.

Only local pages are allowed: any request that is not file:, data: or blob: is blocked and counted.
"""
import argparse
import shutil
import subprocess
import sys
from pathlib import Path

from playwright.sync_api import sync_playwright


def find_ffmpeg():
    found = shutil.which("ffmpeg")
    if found:
        return found
    import os
    link = Path(os.environ.get("LOCALAPPDATA", "")) / "Microsoft" / "WinGet" / "Links" / "ffmpeg.exe"
    if link.exists():
        return str(link)
    sys.exit("ffmpeg not found. Install it (winget install Gyan.FFmpeg) and reopen the shell.")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("page", help="path to a local HTML file that defines window.renderFrame(t)")
    ap.add_argument("--out", required=True, help="output MP4 path")
    ap.add_argument("--fps", type=int, default=30)
    ap.add_argument("--duration", type=float, default=3.0, help="seconds")
    ap.add_argument("--width", type=int, default=1280)
    ap.add_argument("--height", type=int, default=720)
    ap.add_argument("--audio", help="optional audio file to mux in (wav, m4a, mp3)")
    ap.add_argument("--only", help="re-render only these frame numbers, e.g. 12-18,40")
    args = ap.parse_args()

    ffmpeg = find_ffmpeg()
    out = Path(args.out).resolve()
    out.parent.mkdir(parents=True, exist_ok=True)
    frames = out.with_name(out.stem + "_frames")
    frames.mkdir(exist_ok=True)
    total = round(args.fps * args.duration)

    wanted = set(range(total))
    if args.only:
        wanted = set()
        for part in args.only.split(","):
            lo, _, hi = part.partition("-")
            wanted.update(range(int(lo), int(hi or lo) + 1))
        wanted &= set(range(total))
    else:
        for old in frames.glob("frame_*.png"):
            old.unlink()

    blocked = []

    def gate(route):
        if route.request.url.split(":", 1)[0] in ("file", "data", "blob"):
            route.continue_()
        else:
            blocked.append(route.request.url)
            route.abort()

    page_url = Path(args.page).resolve().as_uri()
    with sync_playwright() as pw:
        browser = pw.chromium.launch()
        page = browser.new_page(viewport={"width": args.width, "height": args.height})
        page.route("**/*", gate)
        page.goto(page_url)
        page.wait_for_function("typeof window.renderFrame === 'function'", timeout=10000)
        page.evaluate("window.ready ? window.ready : null")  # lets a page await fonts or images
        for i in sorted(wanted):
            page.evaluate("t => window.renderFrame(t)", i / args.fps)
            page.evaluate("() => new Promise(r => requestAnimationFrame(() => requestAnimationFrame(r)))")
            page.screenshot(path=str(frames / f"frame_{i:05d}.png"))
        browser.close()

    cmd = [ffmpeg, "-y", "-loglevel", "error", "-framerate", str(args.fps), "-i", str(frames / "frame_%05d.png")]
    if args.audio:
        cmd += ["-i", args.audio, "-shortest", "-c:a", "aac"]
    cmd += ["-c:v", "libx264", "-pix_fmt", "yuv420p", str(out)]
    subprocess.run(cmd, check=True)

    sheet = out.with_name(out.stem + "_sheet.png")
    subprocess.run([ffmpeg, "-y", "-loglevel", "error", "-i", str(out),
                    "-vf", f"fps={max(1, args.fps // 5)},scale=320:-1,tile=4x3", "-frames:v", "1", str(sheet)],
                   check=True)

    print(f"frames: {len(wanted)} rendered of {total}")
    print(f"video:  {out}")
    print(f"sheet:  {sheet}")
    print(f"blocked remote requests: {len(blocked)}")
    for u in blocked:
        print("  blocked:", u)


if __name__ == "__main__":
    main()
