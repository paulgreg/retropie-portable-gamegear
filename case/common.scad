screenExtW = 120;
screenExtH = 75;
screenIntW = 110;
screenIntH = 67;
screenZ = 3;
screenIntX = 5;
screenIntY = 6;

H  = 100;
W = 44 * 2 + screenIntW; // 198
Z   = 25;
thickness = 1;

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

resetStartPcbW =30;
resetStartPcbH = 13;

batteryW = 61;
batteryH = 36;
batteryZ = 8;

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