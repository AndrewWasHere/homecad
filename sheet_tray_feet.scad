channel_r_inner = 25;
channel_r_outer = 35;
channel_depth = 3;
lift = 5;
edge_thickness = 2;
run_length = 10;

module template(depth, r_outer, r_inner, run_length) {
    linear_extrude(depth) {
        union() {
            translate([0, r_inner, 0]) {
                square([run_length, r_outer - r_inner]);
            }
            translate([-r_outer, -run_length, 0]) {
                square([r_outer - r_inner, run_length]);
            }
            difference() {
                circle(r_outer);
                circle(r_inner);
                square(r_outer);
                translate([0, -r_outer / 2, 0]) {
                    square([2 * r_outer, r_outer], center=true);
                }
            }
        }
    }
}

module channel() {
    template(
        channel_depth, 
        channel_r_outer, 
        channel_r_inner, 
        run_length
    );
}

module foot() {
    template(
        lift + channel_depth, 
        channel_r_outer + edge_thickness, 
        channel_r_inner - edge_thickness, 
        run_length
    );
}

difference() {
    foot();
    translate([0, 0, lift]) channel();
}