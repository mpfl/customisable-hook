/* Customisable hook */

/* All lengths in millimetres */

// Length of horizontal arm - this will be shortened with larger holders
arm_length = 150;

// Length of vertical support
support_length = 150;

// Radius of holder
holder_radius = 20;

// Inside measurement along the top of the hook
hook_inside_top_length = 25;

// Inside measurement down the back of the hook
hook_inside_back_length = 25;

// Length of standoff to hold support from wall (set to 0 if not needed)
standoff_length = 9.5;

// Height of standoff
standoff_height = 20;

// Horizontal size - fatter is more sturdy
thickness = 20;

// Bulk - fatter is more sturdy
bulk = 10;

// Smoothness (Thingiverse prefers lower values here)
smoothness = 120; // [30: rough, 60: okay, 120: good]
$fn = smoothness;

/* Calculated values */

holder_inside_radius = holder_radius - bulk;

hook_top_length = hook_inside_top_length + bulk;
hook_back_length = hook_inside_back_length + bulk;


triangle_length = pow(pow(arm_length,2) + pow(support_length,2),0.5);
triangle_angle = atan((arm_length)/(support_length));

truncation = (holder_radius - bulk/2) / tan(atan(support_length/arm_length)/2);

/* Back of hook */
translate([0,0-hook_top_length,0])
    union() {
        translate([0,0,0-hook_back_length])
            rotate([0,90,0])
                cylinder(h = thickness, r = bulk/2);
        translate([0,0-bulk/2,0-hook_back_length])
            cube([thickness, bulk, hook_back_length]);
    }

/* Top of hook */
translate([0,0-hook_top_length,0])
    union() {
        translate([0,0,0])
            rotate([0,90,0])
                cylinder(h = thickness, r = bulk/2);
        translate([0,0,0-bulk/2])
            cube([thickness, hook_top_length, bulk]);
    }

/* Support */

translate([0,0,0-support_length])
    union() {
        translate([0,0,0])
            rotate([0,90,0])
                cylinder(h = thickness, r = bulk/2);
        translate([0,0-bulk/2,0])
            cube([thickness, bulk, support_length]);
    }

/* Standoff */
translate([0,0-standoff_length-bulk/2,0-support_length-bulk/2])    
    cube([thickness, standoff_length+bulk/2, standoff_height]);

/* Arm */
translate([0,0,0-bulk/2])
    cube([thickness, arm_length-truncation, bulk]);
    
/* Triangle */

translate([0,0,0-support_length])
    rotate([0-triangle_angle,0,0])
        translate([0,0-bulk/2,0])
            cube([thickness, bulk, triangle_length-truncation]);

/* Holder */

translate([0,arm_length-truncation,0-holder_radius+bulk/2])
    rotate([0,90,0])
        difference() {
            cylinder(h = thickness, r = holder_radius);
            translate([0,0,-1])
                cylinder(h = thickness+2, r = holder_inside_radius);
        }