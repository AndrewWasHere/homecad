/*
    Soap Dispenser Tray.
    Andrew Lin, December 2021.
*/

// Settings (all dimensions in mm).
length = 80;
width = 50;
hole_width = 10;
min_hole_spacing = 1;
face_height = 5;
leg_height = 10;
leg_thickness = 3;
curve_radius = 2.5;

module leg(r, t, h) {
    linear_extrude(h) {
        difference() {
            minkowski() {
                square(2 * r, center = true);
                circle(r);
            }
            translate([-t, -t, 0]) square(3 * r + t, center = true);
        }
    }
}

module holes(l, w, d, b) {
    dx = (l - d) / floor((l - d) / (d + b));
    dy = (w - d) / floor((w - d) / (d + b));
    translate([-l / 2, -w / 2, 0]) {
        for (x = [0:dx:l - d], y = [0:dy:w - d]) {
            translate([x, y, 0]) square(d);
        }
    }
}
module face(l, w, h, b, r, height) {
    linear_extrude(height) {
        difference() {
            minkowski() {
                square([l, w], center = true);
                circle(r);
            }
            holes(l, w, h, b);
        }
    }
}

dx_leg = length / 2 - curve_radius;
dy_leg = width / 2 - curve_radius;

face(length, width, hole_width, min_hole_spacing, curve_radius, face_height);
translate([dx_leg, dy_leg, 0]) leg(curve_radius, leg_thickness, leg_height);
translate([-dx_leg, dy_leg, 0]) rotate([0, 0, 90]) leg(curve_radius, leg_thickness, leg_height);
translate([-dx_leg, -dy_leg, 0]) rotate([0, 0, 180]) leg(curve_radius, leg_thickness, leg_height);
translate([dx_leg, -dy_leg, 0]) rotate([0, 0, 270]) leg(curve_radius, leg_thickness, leg_height);
