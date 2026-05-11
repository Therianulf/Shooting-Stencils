// Digital Camo Spray Paint Stencil - Hexagons
// 180 x 60 x 5 mm
// Pointy-top hex grid. Each cutout is smaller than its cell so a thin
// web of material remains between every neighbor.

// ===== Parameters =====
length      = 180;   // X
height      = 60;    // Y
thickness   = 5;     // Z
hex_size    = 6;     // cell circumradius (center to vertex)
cutout_size = 5;     // cutout circumradius (smaller leaves a thicker web)
frame       = 4;     // outer frame on all sides
fill_pct    = 45;    // 0..100, percent of hex cells that get cut

// ===== Computed (pointy-top geometry) =====
hex_w  = sqrt(3) * hex_size;   // flat-to-flat width
hex_h  = 2 * hex_size;         // point-to-point height
h_step = hex_w;                // horizontal center-to-center step
v_step = 1.5 * hex_size;       // vertical center-to-center step

// Number of cells that fit. Iterate slightly past and let the bounds
// check filter out any hex whose body would cross the frame.
cols = floor((length - 2 * frame - hex_w) / h_step) + 2;
rows = floor((height - 2 * frame - hex_h) / v_step) + 1;

// ===== Main =====
linear_extrude(height = thickness)
    difference() {
        square([length, height]);
        for (r = [0 : rows - 1])
            for (c = [0 : cols - 1]) {
                x_off = (r % 2 == 1) ? h_step / 2 : 0;
                cx = frame + hex_w / 2 + c * h_step + x_off;
                cy = frame + hex_size + r * v_step;
                // Only cut if the full hex fits inside the frame
                if (cx + hex_w / 2 <= length - frame
                    && cy + hex_size <= height - frame
                    && should_cut(c, r)) {
                    translate([cx, cy])
                        rotate(30)
                            circle(r = cutout_size, $fn = 6);
                }
            }
    }

// ===== Deterministic pseudo-random selector =====
function should_cut(c, r) =
    ((c * 73 + r * 31 + c * r * 17 + 11) % 100) < fill_pct;
