screenExtW = 120;
screenExtH = 75;
screenIntW = 110;
screenIntH = 67;
screenZ = 3;
screenIntX = 5;
screenIntY = 6;
screenX = 38;
screenY = 20;

H  = 100;
W = 44 * 2 + screenIntW;
Z   = 25;
thickness = 1;

pcbW = 31;
pcbH = 39;

bigButtonX = 16;
bigButtonY = 10;

pillar = 8;
pillarHole = 1;

DEBUG=!true;

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
        crossH = 8;
        cube([crossH, crossW, thickness*2]);
        translate([-(crossW-crossH)/2,(crossH+crossH)/2,0])  cube([crossW, crossH, thickness*2]);
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

        // power button extrusion
        translate([45, H-thickness, 5]) cube([10, 4+10, 4]);

        dpad(16, 55);
        buttons(W-27, 66);

        // top d-pad button - hole
        translate([bigButtonX, H+thickness, Z-bigButtonY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*20);

        // top buttons button - hole
        translate([W-bigButtonX, H+thickness, Z-bigButtonY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*2);
    }
    
    // top button support
    translate([pillar, H-8.5, Z-bigButtonX]) cube([14, 1, bigButtonX]);
    translate([W-pillar-14, H-8.5, Z-bigButtonX]) cube([14, 1, bigButtonX]);

    // pillars for screws
    pillar(0, 0);                               // bottom dpad
    pillar(0, H-pillar-0.5);             // top dpad
    pillar(W-pillar, 0);                    // bottom buttons
    pillar(W-pillar, H-pillar-0.5);  // top buttons
    
    holder(36, 81, pcbW, pcbH, 10, 8); // dpad holder
    holder(193, 81, pcbW, pcbH, 10, 8); // dpad holder

    holder(screenX+screenExtW, screenY + screenExtH, screenExtW, screenExtH, 4, 15); // screen holder
    
    // D-pad PCB holder
    holder();
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