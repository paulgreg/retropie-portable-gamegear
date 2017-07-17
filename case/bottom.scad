include <common.scad>;

DEBUG=false;

union() {
    difference() {
        color ("yellow") minkowski() {
            cube([W, H, thickness]);
            cylinder(r=1,h=1,  $fn=20);
        }
        // hole for volume
        color("blue") volume(volumeX + 2, H-2);

        // holes for screw
        color("blue") {
            pillar(0, 0);                               // bottom dpad
            pillar(0, H-pillar-0.5);             // top dpad
            pillar(W-pillar, 0);                    // bottom buttons
            pillar(W-pillar, H-pillar-0.5);  // top buttons
        }
     }

    // Pi support
    color("green") support4(screenX + 37, screenY + 25, 64, 55, 3, 8);

    // Battery holder
   color("green")  translate([0, 0, -batteryZ - 5]) holder(149, 38, batteryW, batteryH, batteryZ + 2, 10); // start reset holder
    
    // power boost support
    boostZ = 4;
    color("green") support2(W - 4.5, 16.5, 22, 2, boostZ);
    color("green") support2(W - 36, 19.5, 16, 2, boostZ);
    
    // usb encoder support
    encZ = 4;
    support2(thickness + 37.5, 12, 30.5, 2, encZ); 
    translate([thickness + 2.5, 25, 0]) cylinder(r=2, h=encZ,  $fn=20);

    // dpad support
    //color("violet") support4(dpadX - 7, dpadY - 10, pcbW - 2, pcbH - 4, 2, Z - 5);
    // buttons support
    //color("blue") support4(buttonsX - 6, buttonsY - 20, pcbW - 2, pcbH - 4, 2, Z - 5);

    // screen support
    //color("white") support4(screenX + 8, screenY + 8, screenExtW - 12, screenExtH - 10, 2, Z - 3);
   
    if (DEBUG) {
        translate([0, 0, 80]) import("top.stl");
        color("red") translate([screenX + 33.5, screenY + 21.5, 8]) import("pi-aplus.stl");
        color("blue") translate([W - 36.5 - thickness - 1, 14, 4 ]) powerboost();
        color("brown") translate([thickness, 9, 3]) usbEncoder();
    }
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
    difference() {
        union() {
            translate([x, y, 0]) cylinder(r=R, h=z,  $fn=20);
            translate([x, y + h - R*2, 0]) cylinder(r=R, h=z,  $fn=20);
        }
        screwR = 1;
        screwZ = 3;
        translate([x, y, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
        translate([x, y + h - R*2, screwZ]) cylinder(r=screwR, h=z,  $fn=20);
    }
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
