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

rotation_before_print=0;
rotate([0, rotation_before_print, 0]) {

    // screen emulation
    translate([screenX, screenY, Z -screenZ]) {
    difference() {
        cube([screenExtW, screenExtH, screenZ]);
        translate([screenIntX, screenIntY, 0])cube([screenIntW, screenIntH, screenZ]);
    }
}
    
    union () {
        difference () {
            // box
            //minkowski() {
                cube([W,H,thickness+Z]);
                //cylinder(r=1,h=1);
            //}
            // extrusion
            translate([thickness, thickness, 0]) cube([W-(2*thickness) ,H-(2 * thickness),Z]);
            
            // screen extrusion
            translate([screenX+screenIntX, screenY+screenIntY, Z]) cube([screenIntW, screenIntH, screenZ]);

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
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2, $fn=10);
         }
         // top
         translate([0, H-pillar-0.5, 0]) {
            difference() {
                cube([pillar, pillar, Z]);
                translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2, $fn=10);
             }
         }

        // PCB attachments
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
         // board simulation
         //translate([10, 42, 20]) cube([31, 39, 1]);
     }
 }
