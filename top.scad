H = 100;
W   = 60;
Z    = 25;
thickness = 1;

union () {
    difference () {  
        // box
        //minkowski() {
            cube([W,H,thickness+Z]);
            //cylinder(r=1,h=1);
        //}
        translate([thickness, thickness, 0]) cube([W-thickness+10 ,H-(2 * thickness),Z]);

        // cross
        crossY = 55;
        crossX = 20;
        translate([crossX, crossY, Z]) union() {
            crossW = 25;
            crossH = 8;
            cube([crossH, crossW, thickness*2]);
            translate([-(crossW-crossH)/2,(crossH+crossH)/2,0])  cube([crossW, crossH, thickness*2]);
        }
     }
     
     pillar = 8;
     // bottom pillar
     difference() {
        cube([pillar, pillar, Z]); 
        translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2);
     }

     // top pillar
     translate([0, H-pillar-0.5, 0]) {
        difference() {
            cube([pillar, pillar, Z]); 
            translate([pillar/2, pillar/2, -(Z-10)]) cylinder(r=2,h=Z*2);
         }
     }
          
     attachW = 15;
     attachZ = 8;
     // bottom attach
     translate([17, 41, Z-attachZ]) cube([attachW, 1, attachZ]);
     translate([17, 41, Z-attachZ]) cube([attachW, 2, 1]); 

     // top attach
     translate([17, 81, Z-attachZ]) cube([attachW, 1, attachZ]);
     translate([17, 80, Z-attachZ]) cube([attachW, 2, 1]); 

     // right attach
     translate([9, 60, Z-attachZ]) cube([1, attachW, attachZ]);
     translate([10, 60, Z-attachZ]) cube([1, attachW, 1]); 

     // left attach
     translate([41, 60, Z-attachZ]) cube([1, attachW, attachZ]);
     translate([40, 60, Z-attachZ]) cube([1, attachW, 1]); 

     // board - to debug
     //translate([10, 42, 20]) cube([31, 39, 1]);
 }
 
