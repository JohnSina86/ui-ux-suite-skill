# Run headless: blender -b -P blender_export.py -- <out.glb>
# Builds a placeholder scene and exports it as binary glTF for Three.js. Replace the build step with the real model.
import sys
import bpy

out = sys.argv[sys.argv.index("--") + 1] if "--" in sys.argv else "scene.glb"

bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.mesh.primitive_torus_add(major_radius=1.0, minor_radius=0.35)
bpy.ops.object.shade_smooth()

bpy.ops.export_scene.gltf(filepath=out, export_format="GLB", export_apply=True)
print("exported", out)
