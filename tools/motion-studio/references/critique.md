# Frame critique

The contact sheet (`*_sheet.png`) shows about five frames per second of the video. Open it, then open full frames for anything that looks wrong.

## Contents
- [Grade each frame](#grade-each-frame)
- [Hunt list](#hunt-list)
- [Fix loop](#fix-loop)

## Grade each frame
Score out of 10. Write the number and one reason. A frame passes at 8 or more.
- **Composition:** one clear subject, a deliberate hierarchy, nothing cropped by accident.
- **Type:** readable size, a real typeface, left or asymmetric alignment unless the brief says otherwise.
- **Motion:** the pose is mid-move or settled, never mid-glitch. Overshoot is small and recovers.
- **Specific:** could this frame belong to any other brand? If yes, it loses two points.

## Hunt list
- Dull frames: a long stretch where nothing changes. Cut it or give it a second layer of motion.
- All-caps centred text on a gradient, a stock violet or blue accent, three equal cards.
- Text colliding with a shape mid-move, or leaving the safe area.
- A first frame that is empty. Frame 0 should already show the subject or a held pose.
- A last frame that does not settle. Hold the final pose for at least half a second.

## Fix loop
1. List the frame numbers under 8.
2. Change the scene code, not the render settings.
3. Re-render only those frames: `--only 12-18,40`. The script re-stitches the whole video.
4. Re-grade the same frames. Stop after three rounds and report what is still under 8.
