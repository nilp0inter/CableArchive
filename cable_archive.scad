// Cable Archive - Parametric Cable Organizer
// ============================================
// Modular design: each insert can be stacked with others to cover entire drawers

// === MAIN PARAMETERS ===

/* [Panel Dimensions] */
panel_width = 60;
panel_height = 310;
panel_thickness = 3;

/* [Main Slot Configuration] */
enable_main_slot = true;
slot_width = 3;
entry_diameter = 25;
end_rounding = true;
slot_margin_horizontal = 10;
slot_margin_vertical = 10;

/* [Perpendicular Slots Configuration] */
enable_perpendicular_slots = true;
perpendicular_slot_spacing = 25;
perpendicular_slot_end_radius = 3;
perpendicular_slot_margin = 5;

/* [Base Walls Configuration] */
wall_height = 20;
wall_thickness = 2;

/* [Cross Cutout Configuration] */
cross_margin_width = 5;
cross_margin_height = 5;
cross_margin_top = 2;

/* [Rendering Quality] */
$fn = 50;

// === CALCULATED VALUES (DO NOT EDIT) ===
slot_length = panel_height - 2*slot_margin_horizontal - entry_diameter/2 - slot_width/2;
cross_width_horizontal = panel_width - 2*cross_margin_height;
cross_width_vertical = panel_height - 2*cross_margin_width;
available_space_for_perpendicular = slot_length - (entry_diameter/2 + perpendicular_slot_spacing/2);
num_perpendicular_slots = floor(available_space_for_perpendicular / perpendicular_slot_spacing) + 1;

// === MODULES ===

module panel() {
    cube([panel_height, panel_width, panel_thickness]);
}

module walls() {
    difference() {
        cube([panel_height, panel_width, wall_height]);
        
        translate([wall_thickness, wall_thickness, -1])
            cube([
                panel_height - 2*wall_thickness, 
                panel_width - 2*wall_thickness, 
                wall_height + 2
            ]);
    }
}

module cross_cutout() {
    cutout_height = wall_height - cross_margin_top + 2;
    
    union() {
        translate([-1, cross_margin_height, -1])
            cube([panel_height + 2, cross_width_horizontal, cutout_height]);
        
        translate([cross_margin_width, -1, -1])
            cube([cross_width_vertical, panel_width + 2, cutout_height]);
    }
}

module base() {
    difference() {
        walls();
        cross_cutout();
    }
}

module cable_slot() {
    union() {
        circle(d = entry_diameter);
        
        translate([0, -slot_width/2, 0])
            square([slot_length, slot_width]);
        
        if (end_rounding) {
            translate([slot_length, 0, 0])
                circle(d = slot_width);
        }
    }
}

module perpendicular_slot_full() {
    available_height_above = panel_width/2 - perpendicular_slot_margin;
    available_height_below = panel_width/2 - perpendicular_slot_margin;
    total_length = available_height_above + available_height_below;
    
    union() {
        translate([0, -available_height_below, 0])
            circle(r = perpendicular_slot_end_radius);
        
        translate([-slot_width/2, -available_height_below, 0])
            square([slot_width, total_length]);
        
        translate([0, available_height_above, 0])
            circle(r = perpendicular_slot_end_radius);
    }
}

module all_perpendicular_slots() {
    if (enable_perpendicular_slots && num_perpendicular_slots > 0) {
        for (i = [0:num_perpendicular_slots-1]) {
            x_pos = slot_length - i * perpendicular_slot_spacing;
            
            translate([x_pos, 0, 0])
                perpendicular_slot_full();
        }
    }
}

module cable_insert() {
    union() {
        translate([0, 0, wall_height])
            difference() {
                panel();
                
                translate([
                    slot_margin_horizontal + entry_diameter/2, 
                    panel_width/2, 
                    -1
                ])
                    linear_extrude(height = panel_thickness + 2) {
                        if (enable_main_slot) {
                            cable_slot();
                        }
                        all_perpendicular_slots();
                    }
            }
        
        base();
    }
}

// === RENDERING ===

cable_insert();
