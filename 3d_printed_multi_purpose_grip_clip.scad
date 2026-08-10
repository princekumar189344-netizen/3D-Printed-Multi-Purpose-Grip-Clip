// 3D Printed Multi Purpose Grip Clip
// Simple beginner OpenSCAD model

$fn = 32;

clip_length = 75;
arm_width = 16;
arm_thickness = 5;
gap = 22;

hinge_radius = 6;
hinge_hole = 3.2;
bump_height = 2;

module rounded_box(x, y, z, r=2) {
    hull() {
        translate([r,r,0]) cylinder(r=r,h=z);
        translate([x-r,r,0]) cylinder(r=r,h=z);
        translate([r,y-r,0]) cylinder(r=r,h=z);
        translate([x-r,y-r,0]) cylinder(r=r,h=z);
    }
}

module arm() {
    difference() {
        rounded_box(clip_length, arm_width, arm_thickness, 3);

        translate([8, arm_width/2, -1])
            cylinder(r=hinge_hole, h=arm_thickness+2);

        translate([clip_length-8, arm_width/2, -1])
            cylinder(r=3, h=arm_thickness+2);
    }

    // simple grip ridges
    for (i=[0:4]) {
        translate([clip_length-30+i*5, -1, arm_thickness])
            cube([3, arm_width+2, bump_height]);
    }
}

module grip_clip() {
    arm();

    translate([0, gap+arm_width, 0])
        arm();

    // hinge cylinder
    translate([8, arm_width/2 + gap/2, arm_thickness/2])
        rotate([90,0,0])
        difference() {
            cylinder(r=hinge_radius, h=gap+arm_width, center=true);
            cylinder(r=hinge_hole, h=gap+arm_width+2, center=true);
        }

    // middle connector
    translate([5, arm_width, 0])
        rounded_box(6, gap, arm_thickness, 1.5);
}

grip_clip();
