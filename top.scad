H         = 100;
W         = 60;
Z         = 25;
thickness = 1;

rotation_before_print=180;
rotate([0, rotation_before_print, 0]) {
    union () {
        difference () {
            // box
            //minkowski() {
                cube([W,H,thickness+Z]);
                //cylinder(r=1,h=1);
            //}
            // extrusion
            translate([thickness, thickness, 0]) cube([W-thickness+10 ,H-(2 * thickness),Z]);

            // D-pad
            crossY = 55;
            crossX = 20;
            translate([crossX, crossY, Z]) union() {
                crossW = 25;
                crossH = 8;
                cube([crossH, crossW, thickness*2]);
                translate([-(crossW-crossH)/2,(crossH+crossH)/2,0])  cube([crossW, crossH, thickness*2]);
            }

            // top button - hole
            translate([16, H, Z-10]) rotate([90, 0, 0]) cylinder(r=5,h=thickness);
         }
         // top button support
         supportZ= 16;
        translate([8, H-8.5, Z-supportZ]) cube([14, 1, supportZ]);


         // pillars for screws
         pillar = 8;
         // bottom
         difference() {
            cube([pillar, pillar, Z]);
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2);
         }
         // top
         translate([0, H-pillar-0.5, 0]) {
            difference() {
                cube([pillar, pillar, Z]);
                translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2);
             }
         }

        // PCB attachments
        difference() {
            attachW = 20;
            attachZ = 11;
            union() {
                 // bottom
                 translate([14, 41, Z-attachZ]) cube([attachW, 1, attachZ]);
                 // top
                 translate([14, 81, Z-attachZ]) cube([attachW, 1, attachZ]);
                 // right
                 translate([9, 55, Z-attachZ]) cube([1, attachW, attachZ]);
                 // left
                 translate([41, 55, Z-attachZ]) cube([1, attachW, attachZ]);
            }
            // holes
            translate([5, 58, Z-attachZ+2]) rotate([0, 90, 0]) cylinder(r=1, h=40, $fn=10);
            translate([5, 72, Z-attachZ+2]) rotate([0, 90, 0]) cylinder(r=1, h=40, $fn=10);
         }
         // board simulation
         //translate([10, 42, 20]) cube([31, 39, 1]);
     }
 }
