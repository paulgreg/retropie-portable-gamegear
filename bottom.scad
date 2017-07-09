include <common.scad>;

DEBUG=false;

if (DEBUG) translate([0, 0, 50]) import("top.stl");

supportZ = DEBUG ? 80 :  Z - 5;

module support(x, y, w, h, R, z) {
    difference() {
        union() {
            translate([x, y, 0]) cylinder(r=R, h=z,  $fn=20);
            translate([x + w - R*2, y, 0]) cylinder(r=R, h=z,  $fn=20);
            translate([x, y + h - R*2, 0]) cylinder(r=R, h=z,  $fn=20);
            translate([x + w - R*2, y + h - R*2, 0]) cylinder(r=R, h=z,  $fn=20);
        }
        screwR = 1;
        screwZ = 3;
        translate([x, y, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
        translate([x + w - R*2, y, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
        translate([x, y + h - R*2, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
        translate([x + w - R*2, y + h - R*2, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
    }
}

union() {
    color ("yellow") minkowski() {
        cube([W, H, thickness]);
        cylinder(r=1,h=1,  $fn=20);
    }
    // dpad support
    color("violet") support(dpadX - 7, dpadY - 10, pcbW - 2, pcbH - 4, 2, supportZ);
    // buttons support
    color("blue") support(buttonsX - 6, buttonsY - 20, pcbW - 2, pcbH - 4, 2, supportZ);

    // screen support
    color("white") support(screenX + 8, screenY + 8, screenExtW - 12, screenExtH - 10, 2, supportZ);


    // Pi support
    color("green") support(screenX + 40, screenY + 22, 64, 55, 3, 8);
   
    if (DEBUG) color("red") translate([screenX + 36.5, screenY + 18.5, 8]) import("pi-aplus.stl");
}
