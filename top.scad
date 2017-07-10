include <common.scad>;

bigButtonX = 16;
bigButtonY = 10;

DEBUG=false;

module startReset(x, y) {
    buttonR = 4;
    d = 9;
    translate([x-d/2, y, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x +d/2, y, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
}

module buttons(x, y) {
    buttonR = 5;
    d = 15;
    translate([x, y, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d, y, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d/2, y+d/2, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
    translate([x+d/2, y-d/2, Z]) cylinder(r=buttonR,h=Z*2, $fn=20);
}

module dpad(crossX, crossY) {
    translate([crossX, crossY, Z]) {
        crossW = 25;
        crossH = 9;
        cube([crossH, crossW, thickness*2]);
        translate([-crossW/3,crossW/3,0])  cube([crossW, crossH, thickness*2]);
        
        translate([4.25, 12.5, 0]) cylinder(r=27/2, h=1, $fn=40);
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

module holder (x, y, w, h, attachH, attachW) {
        attachThick = 1;
        // top (left)
        translate([x-attachW+attachThick, y, Z-attachH]) cube([attachW, attachThick, attachH]);
        // left (top)
        translate([x, y-attachW, Z-attachH]) cube([attachThick, attachW, attachH]);
        // top (right)
        translate([x-w-attachThick, y, Z-attachH]) cube([attachW, attachThick, attachH]);
        // right (top)
        translate([x-w-attachThick, y-attachW, Z-attachH]) cube([attachThick, attachW, attachH]);
        // bottom(left)
        translate([x-attachW+attachThick, y-h-attachThick, Z-attachH]) cube([attachW, attachThick, attachH]);
        // left (bottom)
        translate([x, y-h-attachThick, Z-attachH]) cube([attachThick, attachW, attachH]);
        // top (right)
        translate([x-w-attachThick, y-h-attachThick, Z-attachH]) cube([attachW, attachThick, attachH]);
        // right (bottom)
        translate([x-w-attachThick, y-h-attachThick, Z-attachH]) cube([attachThick, attachW, attachH]);
}

difference () {
    union () {
        difference () {
            // box
            minkowski() {
                cube([W,H,thickness+Z]);
                cylinder(r=1,h=1,  $fn=20);
            }
            // extrusion
            translate([thickness, thickness, 0]) cube([W-(2*thickness) ,H-(2 * thickness),Z]);

            // screen extrusion
            translate([screenX+screenIntX, screenY+screenIntY, Z]) cube([screenIntW, screenIntH, screenZ]);

            dpad(dpadX, dpadY);
            buttons(buttonsX, buttonsY);
            startReset(W/2+thickness, 12);

            // top d-pad button - hole
            translate([bigButtonX, H+thickness, Z-bigButtonY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*20);

            // top buttons button - hole
            translate([W-bigButtonX, H+thickness, Z-bigButtonY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*2);

            // power button extrusion
            translate([165, H-thickness, 0]) cube([10, 4+10, 8]);
            // USBextrusion
            translate([W-thickness, 20, 0]) cube([10, 10, 8]);
        }

        // top button support
        color("purple") translate([pillar, H-8.5, Z-bigButtonX]) cube([14, 1, bigButtonX]);
        color("violet") translate([W-pillar-14, H-8.5, Z-bigButtonX]) cube([14, 1, bigButtonX]);

        // pillars for screws
        color("blue") {
            pillar(0, 0);                               // bottom dpad
            pillar(0, H-pillar-0.5);             // top dpad
            pillar(W-pillar, 0);                    // bottom buttons
            pillar(W-pillar, H-pillar-0.5);  // top buttons
        }

        color("red") holder(36, 81, pcbW, pcbH, 10, 8); // dpad holder
        color("yellow") holder(193, 81, pcbW, pcbH, 10, 8); // dpad holder
        color("green") holder(screenX+screenExtW, screenY + screenExtH, screenExtW, screenExtH, 4, 15); // screen holder

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
            translate([screenIntX, screenIntY, 0])cube([screenIntW, screenIntH, screenZ]);
        }
    }
    //  D-pad board simulation
    translate([5, 42, 15]) cube([pcbW, pcbH, 1]);
    //  buttons board simulation
    translate([W-5-pcbW, 42, 15]) cube([pcbW, pcbH, 1]);
}
