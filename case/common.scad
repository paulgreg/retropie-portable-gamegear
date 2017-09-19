screenExtW = 121;
screenExtH = 76;
screenIntW = 111;
screenIntH = 67;
screenZ = 3;
screenIntX = 5;
screenIntY = 6.5;

screenX = 30;
screenY = 37.5;

pcbW = 24;
pcbH = 39;

H  = 115;
W = 180;
Z   = 25;
thickness = 1.5;

dpadX = 12;
dpadY = 70;

buttonsX = dpadX + pcbW + screenExtW - 0.5;
buttonsY = dpadY + 13;

resetStartPcbW = 31;
resetStartPcbH = 14;

startResetX =  W / 2;
startResetY = 8.5;

jackX = 38;
jackZ = 8;

volumeX = 30;
volumeW = 15;
volumeH = 5;

pillar = 8;
pillarHole = 1;

batteryW = 61;
batteryH = 37;
batteryZ = 8;

piX = 45;
piY = screenY + 20;

powerboostX = W - 4.5;
powerboostY = 16.5;

powerX = 145;
powerY = H-thickness-1;

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
