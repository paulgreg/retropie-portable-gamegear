screenExtW = 121;
screenExtH = 76;
screenIntW = 111;
screenIntH = 67;
screenZ = 3;
screenIntX = 5;
screenIntY = 6.5;

H  = 100;
W = 43.5 * 2 + screenIntW; // 199
Z   = 25;
thickness = 1.5;

dpadX = 13;
dpadY = 54.5;
buttonsX = W-26;
buttonsY = 68;

jackX = 38;
jackZ = 8;

volumeX = 55;
volumeW = 15;
volumeH = 5;

screenX = 38;
screenY = 20;

pcbW = 31;
pcbH = 39;

pillar = 8;
pillarHole = 1;

resetStartPcbW =31;
resetStartPcbH = 14;

batteryW = 61;
batteryH = 37;
batteryZ = 8;

/* Test holder internal W / H
holder(0, 0, 10, 10, 2, 3, 3);
translate([-10, -10, 14]) cube(10, 10);
*/

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
