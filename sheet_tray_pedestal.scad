// Pedestal dimensions in mm.
d_pedestal = 15;
h_pedestal = 50;

// Foot dimensions in mm.
d_foot = 2 * d_pedestal;
h_foot = 5;

// Label dimensions in mm.
h_label = 2;

function mm_to_cm(v) = v / 10;

module label() {
    linear_extrude(h_label) {
        text(
            str(mm_to_cm(h_pedestal)), 
            size=(d_pedestal / 2), 
            halign="center", 
            valign="center"
        );
    }
}

module pedestal() {
    cylinder(h_foot, d=d_foot);
    cylinder(h_pedestal, d=d_pedestal);
}

difference() {
    pedestal();
    translate([0, 0, h_pedestal - h_label]) label();
};
