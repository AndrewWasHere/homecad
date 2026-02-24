$fn = 50;

yeti_od = 103;  // Yeti mug outer diameter in mm.
yeti_handle_width = 22;  // Yeti handle width in mm.
yeti_handle_height = 15;  // Distance from base to bottom of handle on Yeti mug in mm.

cup_holder_diameter = 75;  // Minimum diameter of cup holder in mm.
cup_holder_depth = 78;  // Depth of cup holder in mm.

wall_width = 3;  // Wall thickness in mm.
yeti_holder_height = 75; // Height of part that holds the Yeti mug in mm.
yeti_handle_slot_width = yeti_handle_width + 5;

vent_diameter = 5;

module handle_cutout_negative(w, d, h, r) {
    rotate([90, 0, 0]) {
        translate([r, 0, -d]) {
            minkowski() {
                cube([w, h - r, d / 2]);
                cylinder(r=r, h=d / 2);
            }
        }
    }
}

module handle_cutout() {
    radius_of_curvature = 5;
    h = yeti_holder_height - yeti_handle_height;
    w = yeti_handle_slot_width + (2 * radius_of_curvature);
    d = wall_width * 4;

    translate([-w / 2, 0, 0]) {
        difference() {
            cube([w, d, h]);
            translate([-(w + radius_of_curvature), 0, 0]) {
                handle_cutout_negative(w, d, h, radius_of_curvature);
            }
            translate([w - radius_of_curvature, 0, 0]) {
                handle_cutout_negative(w, d, h, radius_of_curvature);
            }
        }
    }
}

module vent() {
    h = yeti_od + 2 * wall_width;
    translate([-h / 2, 0, 0]) {
        rotate([0, 90, 0]) {
            cylinder(yeti_od + 2 * wall_width, d=vent_diameter);
        }
    }
}

module vents() {
    translate([0, 0, vent_diameter / 2]) {
        for (degs = [-45:45:45]) {
            rotate([0, 0, degs]) {
                vent();
            }
        }
    }
}

module yeti_holder() {
    difference() {
        cylinder(yeti_holder_height, d=(yeti_od + (2 * wall_width)));
        translate([0, 0, wall_width]) {
            cylinder(yeti_holder_height, d=(yeti_od));
        }
        translate([0, (yeti_od - (4 * wall_width)) / 2, yeti_handle_height]) {
            handle_cutout();
        }
        translate([0, 0, wall_width]) {
            vents();
        }
    }
}

module cup_holder_insert() {
    cylinder(cup_holder_depth, d=cup_holder_diameter);
}

cup_holder_insert();
translate([0, 0, cup_holder_depth]) {
    yeti_holder();
};
