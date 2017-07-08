screenExtW =120;
screenExtH = 75;
screenIntW = 110;
screenIntH = 67;
screenZ = 3;
screenIntX = 5;
screenIntY = 6;
screenX = 45;
screenY = 20;

H         = 100;
W         = 50 * 2 + screenIntW;
Z         = 25;
thickness = 1;

holeX = 16;
holeY = 10;

pillar = 8;
pillarHole = 1;

// screen emulation
/*
translate([screenX, screenY, Z -screenZ]) {
difference() {
    cube([screenExtW, screenExtH, screenZ]);
    translate([screenIntX, screenIntY, 0])cube([screenIntW, screenIntH, screenZ]);
}
}
*/

union () {
    difference () {
        // box
        minkowski() {
            cube([W,H,thickness+Z]);
            cylinder(r=1,h=1,  $fn=10);
        }
        // extrusion
        translate([thickness, thickness, 0]) cube([W-(2*thickness) ,H-(2 * thickness),Z]);
        
        // screen extrusion
        translate([screenX+screenIntX, screenY+screenIntY, Z]) cube([screenIntW, screenIntH, screenZ]);
        
      // power button extrusion
      translate([45, H-thickness, 5]) cube([10, 4+10, 4]);

        // D-pad
        crossY = 55;
        crossX = 20;
        translate([crossX, crossY, Z]) union() {
            crossW = 25;
            crossH = 8;
            cube([crossH, crossW, thickness*2]);
            translate([-(crossW-crossH)/2,(crossH+crossH)/2,0])  cube([crossW, crossH, thickness*2]);
        }

        // top d-pad button - hole
        translate([holeX, H+thickness, Z-holeY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*2);

        // top buttons button - hole
        translate([W-holeX, H+thickness, Z-holeY]) rotate([90, 0, 0]) cylinder(r=5,h=thickness*2);
     }
     // top button support
    translate([pillar, H-8.5, Z-holeX]) cube([14, 1, holeX]);
    translate([W-pillar-14, H-8.5, Z-holeX]) cube([14, 1, holeX]);

     // pillars for screws

     // bottom dpad
     difference() {
        cube([pillar, pillar, Z]);
        translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=pillarHole,h=Z*2, $fn=10);
     }
     // top dpad
     translate([0, H-pillar-0.5, 0]) {
        difference() {
            cube([pillar, pillar, Z]);
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=pillarHole,h=Z*2, $fn=10);
         }
     }

translate([W-pillar, 0, 0]) {
     // bottom buttons
     difference() {
        cube([pillar, pillar, Z]);
        translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=pillarHole,h=Z*2, $fn=10);
     }
     // top buttons
     translate([0, H-pillar-0.5, 0]) {
        difference() {
            cube([pillar, pillar, Z]);
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=pillarHole,h=Z*2, $fn=10);
         }
     }
 }

    // D-pad PCB attachments
    difference() {
        attachW = 20;
        attachH = 12;
        attachZ = 1;
        union() {
             // bottom
             translate([15, 42-attachZ, Z-attachH]) cube([attachW, attachZ, attachH]);
             // top
             translate([15, 81, Z-attachH]) cube([attachW, attachZ, attachH]);
             // right
             translate([10-attachZ, 55, Z-attachH]) cube([attachZ, attachW, attachH]);
             // left
             translate([41, 55, Z-attachH]) cube([attachZ, attachW, attachH]);
        }
        // holes
        //translate([5, 58, Z-attachH+2]) rotate([0, 90, 0]) cylinder(r=1, h=40, $fn=10);
        //translate([5, 72, Z-attachH+2]) rotate([0, 90, 0]) cylinder(r=1, h=40, $fn=10);
     }

 }

//  D-pad board simulation
//translate([10, 42, 20]) cube([31, 39, 1]);

//  buttons board simulation
//translate([10, 42, 20]) cube([32, 39, 1]);