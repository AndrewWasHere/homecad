/*

      |----id----|   
       |-not id-|          |\
    _   ________           | \
   h_ _/        \_ <----- h|  \
   h_|____________|        |   \
                           |____\ <-- theta
     |-----od-----|      h/atan(theta) 
*/
h = 2.5;     // mm 
od = 76;     // mm
id = 70;     // mm
theta = 81;  // degrees
$fa = 1;

module plug() {
    d_large = id;
    d_small = id - (2 * (h / atan(theta)));
    cylinder(h=h, d1=d_large, d2=d_small);
}

module lid() {
    cylinder(h=h, d=od);
}

module cap() {
    translate([0, 0, h]) plug();
    lid();
}

cap();
