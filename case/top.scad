include <common.scad>;

bigButtonX = 16;
bigButtonY = 10;

DEBUG=false;

difference () {
    union () {
        difference () {
            // box
            minkowski() {
                cube([W,H,thickness/2+Z]);
                sphere(r=thickness/2,h=1,  $fn=20);
            }
            // extrusion
            translate([thickness, thickness, -5]) cube([W-(2*thickness) ,H-(2 * thickness),Z+5]);
            translate([-5, -5, -5]) cube([W+20,H+20,5]); // to get sharp edge on the bottom

            // screen extrusion
            translate([screenX+screenIntX, screenY+screenIntY, Z-1]) cube([screenIntW, screenIntH, screenZ+1]);

            dpad(dpadX, dpadY);
            buttons(buttonsX, buttonsY);
            startResetHoles(startResetX, startResetY);

            // power button extrusion
            translate([powerX, powerY, -1]) cube([10, 4+10, 8]);
            // volume
            translate([volumeX, thickness-5, -1]) cube([volumeW, 10, volumeH+2]);
            // USBextrusion
            translate([W-thickness-1, 20, -1]) cube([10, 10, 6]);
        }

        // pillars for screws
        color("blue") {
            pillar(0, 0);                               // bottom dpad
            pillar(0, H-pillar-0.5);             // top dpad
            pillar(W-pillar, 0);                    // bottom buttons
            pillar(W-pillar, H-pillar-0.5);  // top buttons
        }

        color("red") holder(dpadX+17, dpadY+26.5, pcbW, pcbH, 12.5, 9); // dpad holder
        color("yellow") holder(buttonsX+19.5, buttonsY+13, pcbW, pcbH, 12.5, 9); // buttons holder
        color("green") holder(screenX+screenExtW, screenY + screenExtH, screenExtW, screenExtH, 10, 15); // screen holder
        color("red") holder(startResetX + 17, startResetY + 7, resetStartPcbW, resetStartPcbH, 12.5, 8); // start reset holder
    }
    // differences to print some part (for trial & errors)
    // for dpad and buttons
    //translate([-thickness*2, H-17, 0]) cube([W+thickness*4, 42, Z+10]); // top
    //translate([-thickness*2, -thickness*2, 0]) cube([W+thickness*4, 42, Z+10]); // bottom
    //translate([W-60, 0, 0]) cube([70, H+10, Z+10]); // remove buttons
    //translate([-thickness, 0, 0]) cube([thickness+3, H+10, Z+10]);  // remove dpad border
    //translate([-thickness*2, -thickness*2, 0]) cube([70, H+10, Z+10]); // remove DPAD
    //translate([W-thickness-1, 0, 0]) cube([thickness+3, H+10, Z+10]);  // remove button border
    // for screen
    //translate([-thickness*2, -thickness*2, 0]) cube([W+thickness*4, 20, Z+10]); // bottom
    //translate([-thickness*2, H-thickness, 0]) cube([W+thickness*4, 40, Z+10]); // top
    //translate([W-37, 0, 0]) cube([50, H+10, Z+10]);  // remove buttons
    //translate([-thickness*2, -thickness*2, 0]) cube([39, H+10, Z+10]); // remove DPAD
}

if (DEBUG) {
    // screen simulation
    translate([screenX, screenY, Z -screenZ]) {
        difference() {
            cube([screenExtW, screenExtH, screenZ]);
            translate([screenIntX, screenIntY, -1])cube([screenIntW, screenIntH, screenZ+2]);
        }
    }
    //  D-pad board simulation
    translate([5, 42, 15]) cube([pcbW, pcbH, 1]);
    //  buttons board simulation
    translate([W-5-pcbW, 42, 15]) cube([pcbW, pcbH, 1]);
}

module startResetHoles(x, y) {
    buttonR = 4.5;
    d = 14;
    translate([x-d/2, y, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d/2+1.5, y, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
}

module buttons(x, y) {
    buttonR = 5;
    d = 15;
    translate([x, y, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d, y, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d/2, y+d/2, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d/2, y-d/2, Z-1]) cylinder(r=buttonR,h=Z*2, $fn=20);
}

module dpad(crossX, crossY) {
    translate([crossX, crossY, Z-2.5]) {
        crossW = 25;
        crossH = 9.5;
        cube([crossH, crossW, 10]);
        translate([-crossW/2+crossH/2,crossW/2-crossH/2,0])  cube([crossW, crossH, 10]);
        translate([4.75, 12.5, 0]) cylinder(r=27/2, h=thickness*2, $fn=40);
    }
}

module pillar(x, y) {
    translate([x, y, 0]) {
        difference() {
            cube([pillar, pillar, Z]);
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=pillarHole,h=Z*2, $fn=10);
        }
    }
}
