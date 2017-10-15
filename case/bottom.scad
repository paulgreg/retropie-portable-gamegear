include <common.scad>;

DEBUG= false;

boostZ = 3;
encZ = 4;

difference() {
    union() {
        color ("yellow") minkowski() {
            cube([W, H, thickness/2]);
            cylinder(r=thickness/2,h=1,  $fn=20);
        }
        
        // Pi support
        color("green") support4(piX, piY, 64, 55, 3, 4);
        
        // power button pillar
        color("red") powerPillar(powerX, powerY);
        
        // Battery holder
       color("green")  translate([0, 0, -batteryZ-6]) holder(174, 72, batteryH, batteryW, batteryZ + 1, 12, 1.5); 
        
        // power boost support
        color("green") support2(powerboostX, powerboostY, 22, 2, boostZ);
        color("green") support2(powerboostX - 31.5, powerboostY+3, 16, 2, boostZ);
        
        // screw holder
        color("green") translate([W/2 - 10, H-5, 0]) cube([20, 3.5, 10]);
        
        // usb encoder support
        //support2(thickness + 37.5, 12, 30.5, 2, encZ); 
        //support1(thickness + 2.5, 25, 2, encZ);
    }

    // holes for 4 screws holding the case
    color("blue") {
        pillar(0, 0);                               // bottom dpad
        pillar(0, H-pillar-0.5);             // top dpad
        pillar(W-pillar, 0);                    // bottom buttons
        pillar(W-pillar, H-pillar-0.5);  // top buttons
        
        pillar(startResetX - 22, 0);                               // right start/reset button
        pillar(startResetX + 17, 0);                               // left start/reset button
    }

    // Pi support
    supportHole4(piX, piY, 64, 55, 3, 8);

    // power boost support
    supportHole2(powerboostX, powerboostY, 22, 2, boostZ);
    //supportHole2(powerboostX - 31.5, powerboostY+3, 16, 2, boostZ);

    // usb encoder support
    //supportHole2(thickness + 37.5, 12, 30.5, 2, encZ); 
    //supportHole1(thickness + 2.5, 25, 2, encZ);
}

if (DEBUG) {
   translate([0, 0, 0+ 2]) import("top.stl");
    color("red") translate([piX - 3.5, piY  - 3.5, 4]) import("pi-aplus.stl");
    color("blue") translate([powerboostX - 34, powerboostY - 2, 4]) powerboost();
    color("brown") translate([58, 20, 4]) usbEncoder();
}

module powerPillar (x, y) {
    translate([x-5, y-4, 0]) cube([4, 3, 8]);
    translate([x +15 - 4, y -4, 0]) cube([4, 3, 8]);
}

module usbEncoder () {
    padW = 40;
    padH = 32;
    padR = 1.5;
    difference() {
        cube([padW, padH, 1]);
        translate([padW - padR - 1, padR + 1, -1]) cylinder(r=padR, h=5,  $fn=20);
        translate([padW - padR - 1, padH - padR - 1, -1]) cylinder(r=padR, h=5,  $fn=20);
        translate([padR + 1, padH / 2, -1]) cylinder(r=padR, h=5,  $fn=20);
    }
}

module powerboost() {
    boostW = 36.5;
    boostH = 23;
    boostR = 1.5;
    difference() {
        cube([boostW, boostH, 1]);
        translate([boostW - boostR - 1, boostR + 1, -1]) cylinder(r=boostR, h=5,  $fn=20);
        translate([boostW - boostR - 1, boostH - boostR - 1, -1]) cylinder(r=boostR, h=5,  $fn=20);
        translate([boostR + 1, boostR + 4, -1]) cylinder(r=boostR, h=5,  $fn=20);
        translate([boostR + 1, boostH - boostR - 4, -1]) cylinder(r=boostR, h=5,  $fn=20);
    }
}

module support4(x, y, w, h, R, z) {
    support2(x, y, h, R, z);
    support2(x + w - R*2, y, h, R, z);
}

module support2(x, y, h, R, z) {
        support1(x, y, R, z);
        support1(x, y + h - R*2, R, z);
}

module support1(x, y, R, z) {
        translate([x, y, 0]) cylinder(r=R, h=z,  $fn=20);
}

module supportHole4(x, y, w, h, R, z) {
    supportHole2(x, y, h, R, z);
    supportHole2(x + w - R*2, y, h, R, z);
}

module supportHole2(x, y, h, R, z) {
    supportHole1(x, y, R, z);
    supportHole1(x, y + h - R*2, R, z);
}

module supportHole1(x, y, R, z) {
    screwR = 1;
    screwZ = 3;
    translate([x, y, -3]) cylinder(r=screwR, h=z*2,  $fn=20);
    translate([x, y, screwZ-thickness*2]) sphere(2, $fn=20);
}

module volume(x, y) {
    translate([x, y, 1]) {
        cylinder(r=0.5, h=thickness*2,  $fn=10);
        translate([10, 0, 0]) cylinder(r=0.5, h=thickness*2,  $fn=10);
    }
}

module pillar(x, y) {
    translate([x, y, 0]) {
        difference() {
            translate([pillar/2, pillar/2, -1]) {
                cylinder(r=pillarHole,h=10, $fn=10);
                sphere(2, $fn=20);
            }
        }
    }
}
