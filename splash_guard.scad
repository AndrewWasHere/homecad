/*
    Splash Guard
*/
splash_guard_depth = 40;  // mm
splash_guard_width = 168;  // mm

h = 40;
b = splash_guard_depth;
theta = atan(h / b);  // degrees

module plate_rear_foot(width) {
    rotate([theta, 0, 0]) {
        linear_extrude(h) square(width, center=false);
    }
}

module splash_plate(width, depth) {
    rotate([0, 90, 0])
        linear_extrude(width)
            polygon([
                [0, 0],
                [0, depth],
                [-5, depth]
            ]);
}

module splash_guard(width, depth) {
    foot_width = 5;
    plate_depth = depth / cos(theta);
    splash_plate(width, plate_depth);
    translate([0, plate_depth - foot_width]) 
        plate_rear_foot(foot_width);
    translate([width / 2 - foot_width, plate_depth - foot_width])
        plate_rear_foot(foot_width);
    translate([width - foot_width, plate_depth - foot_width])
        plate_rear_foot(foot_width);
}

splash_guard(splash_guard_width, splash_guard_depth);
