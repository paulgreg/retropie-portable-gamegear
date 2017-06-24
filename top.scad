height = 100;
width= 200;
thickness = 1.5;

deltaThickness = -1;
removalThickness = 3;

    
difference () {
    // plate
    cube([width,height,thickness]);
     
    // cross
    crossY = 50;
    crossX = 20;
    translate([crossX, crossY, deltaThickness]) union() {
        crossWidth = 25;
        crossHeight = 10;
        cube([crossHeight, crossWidth, removalThickness]);
        translate([-7.5, 7.5, 0]) cube([crossWidth, crossHeight, removalThickness]);
    }
 }
 