/*
   Power strip label holder
*/

l = 40;
w = 20;
h = 2;

$fn = 25;

module edge() {
    translate([0, l, h/2]) rotate([90, 0, 0]) cylinder(l, h/2, h/2);
}

module flat() {
    edge();
    cube([w, l, h]);
    translate([w, 0, 0]) edge();
}

flat();
translate([5 + h, 0, h/2]) rotate([0, -90, 0]) flat();