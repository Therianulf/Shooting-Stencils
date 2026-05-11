// Digital Camo Spray Paint Stencil - Squares
// 180 x 60 x 5 mm
// Grid of square cutouts in a pseudo-random pattern.
// Each cutout is smaller than its cell, leaving a thin web of material
// between every neighbor so the stencil stays in one piece.

// ===== Parameters =====
length    = 180;   // X
height    = 60;    // Y
thickness = 5;     // Z
cell      = 10;    // grid cell size
cutout    = 8;     // cutout square size within cell (cell - cutout = wall thickness)
frame_x   = 5;     // outer frame, sides
frame_y   = 5;     // outer frame, top and bottom
fill_pct  = 45;    // 0..100, percent of cells that get cut

// ===== Computed =====
inner_w = length - 2 * frame_x;
inner_h = height - 2 * frame_y;
cols    = floor(inner_w / cell);
rows    = floor(inner_h / cell);
// Center the grid in the available interior
grid_x  = (length - cols * cell) / 2;
grid_y  = (height - rows * cell) / 2;

// ===== Main =====
linear_extrude(height = thickness)
    difference() {
        square([length, height]);
        for (c = [0 : cols - 1])
            for (r = [0 : rows - 1])
                if (should_cut(c, r))
                    translate([
                        grid_x + c * cell + (cell - cutout) / 2,
                        grid_y + r * cell + (cell - cutout) / 2
                    ])
                        square([cutout, cutout]);
    }

// ===== Deterministic pseudo-random selector =====
// Same (c, r) always yields the same result. Tweak the constants to reshuffle.
function should_cut(c, r) =
    ((c * 73 + r * 31 + c * r * 17 + 11) % 100) < fill_pct;
