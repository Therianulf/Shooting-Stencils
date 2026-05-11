# Spray Paint Stencils

OpenSCAD source for 3D-printable spray paint stencils. Everything is 5mm thick.

## Files

| File | Pattern | Dimensions |
|------|---------|------------|
| `classic_camo_stencil.scad` | Woodland-style camo. Circle clusters with polygon offshoots for irregular shorelines. | 180 x 60 mm |
| `digital_camo_squares_stencil.scad` | Pixelated digital camo, square grid. | 180 x 60 mm |
| `digital_camo_hexagons_stencil.scad` | Digital camo, hex grid. | 180 x 60 mm |
| `hand_stencil.scad` | Life-size hand silhouette. Palm and fingers are hulled circle clusters. | 170 x 220 mm |

## Print

1. Open the `.scad` file in OpenSCAD
2. F6 to render
3. File → Export → Export as STL
4. Slice at 5mm thickness, ~15% infill, PLA is fine

## Customizing

All parameters live at the top of each file or inside the named modules.

**Digital camo (squares, hexagons):** `cell` sets grid spacing, `cutout` sets the visible pixel size (the difference is the wall thickness between adjacent cuts), `fill_pct` sets cut density. The `should_cut(c, r)` hash is deterministic. Change the `+ 11` constant to reshuffle the pattern at the same density.

**Classic camo:** Cluster positions sit in `camo_shapes()`. Circle positions and radii are in the per-cluster modules. Polygon offshoots need at least one vertex inside a cluster circle to merge cleanly, the distance from the offshoot's nearest vertex to a circle's center must be less than that circle's radius.

**Hand:** Finger positions are `finger(base_x, base_y, base_r, tip_x, tip_y, tip_r)` calls in `hand()`. Palm shape is the hull of seven circles in `palm()`. To resize uniformly, wrap `hand()` in a `scale([s, s])` and adjust the outer `width` and `height` to match.

## Use

Hold the stencil flat against the target surface and spray paint through the cutouts. For multi-color camo, paint the base coat first, let it dry, then apply the stencil for each accent color in turn.
