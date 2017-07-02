height = 100;
width   = 60;
thick    =20;
thickness = 1;


union () {
    difference () {  
        // box
        minkowski() {
            cube([width,height,thickness+thick]);
            cylinder(r=1,h=1);
        }
        translate([thickness, thickness, 0]) cube([width-thickness+10 ,height-(2 * thickness),thick]);

        // cross
        crossY = 55;
        crossX = 25;
        translate([crossX, crossY, thick]) union() {
            crossWidth = 25;
            crossHeight = 8;
            cube([crossHeight, crossWidth, thickness*2]);
            translate([-(crossWidth-crossHeight)/2,(crossHeight+crossHeight)/2,0])  cube([crossWidth, crossHeight, thickness*2]);
        }
     }
      cube([8, 8, thick]); 
 }
