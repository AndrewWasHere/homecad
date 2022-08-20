/*
    Rain Barrel Hose Plug
    Andrew Lin, May 2022.
    
    To make an STL file of the plug from the command line, use:
    openscad -D "plug();" rain_barrel_hose_plug.scad -o plug.stl
    
    To make an STL file of the plate from the command line, use:
    openscad -D "plate();" rain_barrel_hose_plug.scad -o plug.stl
    
    In the IDE, uncomment the part you want to print at the end of the file.
    
    When printing, you may want supports on for the plug.
*/

/****************************
    Configuration Settings
*****************************/

/*
    Number of facets to use when creating shapes. Larger is smoother,
    but will take longer to compute.
*/
$fn = 100;

/*
    Dimension in millimeters.
*/

// Plug dimensions.
r_plug = 60;
h_plug = 12;

// Hose hole dimensions.
r_hose = 15;

// Plate dimensions.
r_plate = r_plug + 10;
h_plate = 3;

// Peg dimensions.
r_peg_neck = 2.5;
r_peg_head = 10;
h_peg_head = 5;
h_peg = h_plate + 3 + 2; // 3mm lip on barrel plus wiggle room.
peg_offset = (r_plug / 2) + r_hose;

/****************************
    Modules
*****************************/

module plug_body(h) {
    linear_extrude(h) {
        difference() {
            circle(r_plug);
            circle(r_hose);
        }
    }
}

module peg() {
    union() {
        cylinder(h_peg, r = r_peg_neck);
        translate([0, 0, h_peg]) {
            cylinder(h_peg_head, r = r_peg_head);
        }
    }
}

module plug() {
    union() {
        plug_body(h_plug);
        translate([peg_offset, 0, h_plug]) peg();
        translate([-peg_offset, 0, h_plug]) peg();
        translate([0, peg_offset, h_plug]) peg();
        translate([0, -peg_offset, h_plug]) peg();
    }
}

module channel(r, a, channel_diameter, head_diameter) {
    r_outer = r + (channel_diameter / 2);
    r_inner = r - (channel_diameter / 2);
    union() {
        intersection() {
            difference() {
                circle(r_outer);
                circle(r_inner);
            }
            square(r_outer);
            rotate(a - 90) square(r_outer);
        }
        translate([r, 0, 0]) circle(d=channel_diameter);
        rotate(a) translate([r, 0, 0]) circle(d=head_diameter);
    }
}

module plate() {
    a_channel = 30;
    d_channel = (r_peg_neck * 2) + 2;
    d_channel_head = (r_peg_head * 2) + 2;
    linear_extrude(3) {
        difference() {
            circle(r_plate);
            circle(r_hose);
            channel(peg_offset, a_channel, d_channel, d_channel_head);
            rotate([0, 0, 90]) channel(peg_offset, a_channel, d_channel, d_channel_head);
            rotate([0, 0, 180]) channel(peg_offset, a_channel, d_channel, d_channel_head);
            rotate([0, 0, 270]) channel(peg_offset, a_channel, d_channel, d_channel_head);
        }
    }
}

/****************************
    Assembly
*****************************/
//plug();
//plate();