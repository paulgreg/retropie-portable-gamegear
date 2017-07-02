height = 100;
width= 60;
thickness = 1.5;


difference () {
    // plate
    cube([width,height,thickness]);
     
    // cross
    crossY = 55;
    crossX = 25;
    translate([crossX, crossY, 0]) union() {
        crossWidth = 25;
        crossHeight = 8;
        cube([crossHeight, crossWidth, thickness]);
        translate([-(crossWidth-crossHeight)/2,(crossHeight+crossHeight)/2,0])  cube([crossWidth, crossHeight, thickness]);
    }
 }
 