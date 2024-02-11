/*
    Cable Hanger.
    
    Mountable on a tripod, light stand, mic stand, 
    or any other pole-like object.    
*/

// Useful slot widths
usb = 4.0;      // for "thin" USB cables in mm.
fat_usb = 6.0;  // for "fat" USB cables in mm.
power = 7.0;    // for power cables in mm.

// Useful mount diameters
photo_large = 10.0;  // for 3/8"-16 threaded bolt.
photo_small = 7.0;   // for 1/4"-20 threaded bolt.
mic_stand = 16.0;    // for 5/8"-27 threaded bolt.

// Parameters
h_rack = 4.0;            // height of rack base in mm. Too thin, and it will flex.
h_lip = 2.0;             // height of rack lip above the base in mm.
w_lip = 2.0;             // width of rack lip in mm.
d_rack = 170;            // diameter of rack in mm.
d_mount = photo_large;   // diameter of mounting hole in mm.
slot_width = usb;        // default slot width in mm.

// Derived values
r_rack = d_rack / 2;    // radius of rack.
r_mount = d_mount / 2;  // radius of mounting hole.
slot_length = r_rack - r_mount;

module slot(width) {
    square_length = slot_length - (width / 2);
    offset = (slot_length - width) / 2;
    union() {
        square([square_length, width], true);
        translate([-offset, 0, 0]) {
            circle(d = width);
        }
    }
}

module slots(width=slot_width) {
    shift = width * 3;
    max_y = floor(r_rack / shift) - 1;
    for (y = [1:max_y]) {
        y_offset = y * shift;
        translate([slot_length / 2 + d_mount, -y_offset, 0]) slot(width);
    }
}

module rack_mask() {
    difference() {
        circle(d = d_rack);
        circle(d = d_mount);
        slots(usb);
        rotate(90, [0, 0, 1]) slots(fat_usb);
        rotate(180, [0, 0, 1]) slots(fat_usb);
        rotate(270, [0, 0, 1]) slots(power);
    }
}

module rack() {
    difference() {
        linear_extrude(h_rack + h_lip) rack_mask();
        translate([0, 0, h_rack]) linear_extrude(h_lip) circle(r = r_rack - w_lip);
    }
}

rack();

