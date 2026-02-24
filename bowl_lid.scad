/*

      |----id----|   
       |-not id-|          |\
    _   ________           | \
  h1_ _/        \_ <----- h|  \
  h2_|____________|        |   \
                           |____\ <-- theta
     |-----od-----|      h/atan(theta) 
*/
h1 = 2.5;     // mm 
h2 = 2 * h1;
od = 156;     // mm
id = 149.5;   // mm
theta = 85;   // degrees
$fa = 1;

module plug() {
    d_large = id;
    d_small = id - (2 * (h1 / atan(theta)));
    cylinder(h=h1, d1=d_large, d2=d_small);
}

module lid() {
    cylinder(h=h2, d=od);
}

module cap() {
    translate([0, 0, h2]) plug();
    lid();
}

cap();
