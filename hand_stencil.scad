// Hand Spray Paint Stencil
// 170 x 220 x 5 mm
// Roughly life-size hand cutout, fingers up, thumb to the left.
// Palm is a hull of seven circles for a smooth rounded body.
// Each finger is a hull of a base circle and a tip circle for a
// natural taper. Thumb same construction, just angled outward.

// ===== Parameters =====
width     = 170;
height    = 220;
thickness = 5;
frame     = 6;

$fn = 32;

// ===== Main =====
linear_extrude(height = thickness)
    difference() {
        square([width, height]);
        translate([frame, frame])
            hand();
    }

// ===== Hand =====
// Palm plus five tapered fingers, all unioned into one connected shape.
// Finger bases overlap with the palm's top circles so the union merges
// cleanly without any thin bridges.
module hand() {
    union() {
        palm();
        // finger(base_x, base_y, base_r, tip_x, tip_y, tip_r)
        finger( 60, 108, 10,  52, 178,  8);   // index
        finger( 85, 112, 11,  85, 195,  9);   // middle (longest)
        finger(110, 108, 10, 115, 182,  8);   // ring
        finger(128,  98,  9, 138, 152,  7);   // pinky (shortest, angled out)
        finger( 40,  58, 14,  15, 115, 11);   // thumb (wider, angled up-left)
    }
}

// Palm: hull of seven circles. Two small at the wrist, two big at the
// sides for the broad middle, three at the top to give the fingers a
// platform to emerge from.
module palm() {
    hull() {
        translate([ 52,  18]) circle(r = 12);   // wrist left
        translate([115,  18]) circle(r = 12);   // wrist right
        translate([ 40,  55]) circle(r = 15);   // left side bulge (slimmed)
        translate([122,  60]) circle(r = 15);   // right side bulge (slimmed)
        translate([124,  85]) circle(r = 14);   // pinky-side metacarpal (smooths the knuckle)
        translate([ 60,  98]) circle(r = 17);   // top under index
        translate([ 85, 102]) circle(r = 19);   // top under middle
        translate([110,  98]) circle(r = 17);   // top under ring
    }
}

// Tapered finger via hull of two circles
module finger(bx, by, br, tx, ty, tr) {
    hull() {
        translate([bx, by]) circle(r = br);
        translate([tx, ty]) circle(r = tr);
    }
}
