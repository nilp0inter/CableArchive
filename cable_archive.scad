// Cable Archive - Parametric Cable Organizer
// ============================================
// Modular design: each insert can be stacked with others to cover entire drawers

// === MAIN PARAMETERS ===

/* [Top Panel] */
top_panel_width = 60;
top_panel_height = 310;
top_panel_thickness = 3;

/* [Bottom Panel] */
bottom_panel_enabled = true;

/* [Walls] */
walls_height = 20;
walls_thickness = 2;

/* [Stacking] */
stacking_slab_enabled = true;
stacking_slab_padding = 5;
stacking_slab_depth = 2;
stacking_lip_enabled = true;
stacking_lip_height = 5;
stacking_lip_padding = 2;

/* [Cross Cutout] */
cross_cutout_margin_width = 5;
cross_cutout_margin_height = 5;
cross_cutout_margin_top = 2;

/* [Main Slot] */
main_slot_enabled = true;
main_slot_width = 3;
main_slot_primary_entry_diameter = 0;
main_slot_secondary_entry_diameter = 0;
main_slot_margin = 10;

/* [Per Cable Slot] */
per_cable_slots_enabled = true;
per_cable_slot_spacing = 25;
per_cable_slot_width = 3;
per_cable_slot_end_radius = 3;
per_cable_slot_margin = 5;
per_cable_slot_ends_minimum_margin = 10;

/* [Cable Separators] */
cable_separators_enabled = true;
cable_separator_width = 2;
cable_separator_percentage = 0.5;
cable_separator_extension = 0;

/* [Rendering] */
$fn = 50;

// === CALCULATED VALUES (DO NOT EDIT) ===
slot_length = top_panel_height - 2*main_slot_margin - main_slot_primary_entry_diameter/2 - main_slot_secondary_entry_diameter/2;
cross_cutout_width_horizontal = cross_cutout_margin_height;
cross_cutout_width_vertical = cross_cutout_margin_width;
num_per_cable_slots = floor((slot_length - 2*per_cable_slot_ends_minimum_margin) / per_cable_slot_spacing) + 1;
offset = (slot_length - (num_per_cable_slots - 1) * per_cable_slot_spacing) / 2;
effective_offset = max(per_cable_slot_ends_minimum_margin, offset);

// === MODULES ===

module top_panel() {
    cube([top_panel_height, top_panel_width, top_panel_thickness]);
}

module walls() {
    difference() {
        cube([top_panel_height, top_panel_width, walls_height]);
        
        translate([walls_thickness, walls_thickness, -1])
            cube([
                top_panel_height - 2*walls_thickness, 
                top_panel_width - 2*walls_thickness, 
                walls_height + 2
            ]);
    }
}

module cable_separators() {
    if (cable_separators_enabled && per_cable_slots_enabled && num_per_cable_slots > 1) {
        cable_separator_height = walls_height * cable_separator_percentage;
        cable_separator_total_height = cable_separator_height + cable_separator_extension;
        
        translate([main_slot_margin + main_slot_primary_entry_diameter/2, 0, 0]) {
        for (i = [0:num_per_cable_slots-2]) {
            x_pos = effective_offset + per_cable_slot_spacing * (i + 0.5);
            
            translate([x_pos - cable_separator_width/2, walls_thickness, walls_height - cable_separator_height])
                cube([cable_separator_width, top_panel_width - 2*walls_thickness, cable_separator_height + top_panel_thickness + cable_separator_extension]);
        }
        }
    }
}

module cross_cutout() {
    cutout_height = walls_height - cross_cutout_margin_top + 2;
    
    union() {
        translate([-1, (top_panel_width - cross_cutout_width_horizontal)/2, -1])
            cube([top_panel_height + 2, cross_cutout_width_horizontal, cutout_height]);
        
        translate([(top_panel_height - cross_cutout_width_vertical)/2, -1, -1])
            cube([cross_cutout_width_vertical, top_panel_width + 2, cutout_height]);
    }
}

module base() {
    difference() {
        union() {
            walls();
            cable_separators();
        }
        cross_cutout();
    }
}

module stacking_slab() {
    if (stacking_slab_enabled) {
        assert(bottom_panel_enabled, "Stacking slab requires bottom panel to be enabled");
        translate([stacking_slab_padding, stacking_slab_padding, -top_panel_thickness - stacking_slab_depth])
            cube([
                top_panel_height - 2*stacking_slab_padding,
                top_panel_width - 2*stacking_slab_padding,
                stacking_slab_depth
            ]);
    }
}

module stacking_lip() {
    if (stacking_lip_enabled) {
        translate([0, 0, walls_height + top_panel_thickness]) {
            difference() {
                cube([top_panel_height, top_panel_width, stacking_lip_height]);
                
                translate([stacking_lip_padding, stacking_lip_padding, -1])
                    cube([
                        top_panel_height - 2*stacking_lip_padding,
                        top_panel_width - 2*stacking_lip_padding,
                        stacking_lip_height + 2
                    ]);
            }
        }
    }
}

module cable_slot() {
    union() {
        circle(d = main_slot_primary_entry_diameter);
        
        translate([0, -main_slot_width/2, 0])
            square([slot_length, main_slot_width]);
        
        translate([slot_length, 0, 0])
            circle(d = main_slot_secondary_entry_diameter);
    }
}

module per_cable_slot_full() {
    available_height_above = top_panel_width/2 - per_cable_slot_margin;
    available_height_below = top_panel_width/2 - per_cable_slot_margin;
    total_length = available_height_above + available_height_below;
    
    union() {
        translate([0, -available_height_below, 0])
            circle(r = per_cable_slot_end_radius);
        
        translate([-per_cable_slot_width/2, -available_height_below, 0])
            square([per_cable_slot_width, total_length]);
        
        translate([0, available_height_above, 0])
            circle(r = per_cable_slot_end_radius);
    }
}

module all_per_cable_slots() {
    if (per_cable_slots_enabled && num_per_cable_slots > 0) {
        for (i = [0:num_per_cable_slots-1]) {
            x_pos = effective_offset + per_cable_slot_spacing * i;
            
            translate([x_pos, 0, 0])
                per_cable_slot_full();
        }
    }
}

module cable_insert() {
    union() {
        difference() {
            union() {
                translate([0, 0, walls_height])
                    top_panel();
                
                base();
            }
            
            translate([
                main_slot_margin + main_slot_primary_entry_diameter/2, 
                top_panel_width/2, 
                -1
            ])
                linear_extrude(height = walls_height + top_panel_thickness + cable_separator_extension + 2) {
                    if (main_slot_enabled) {
                        cable_slot();
                    }
                    all_per_cable_slots();
                }
        }
        
        stacking_lip();
        
        if (bottom_panel_enabled) {
            translate([0, 0, -top_panel_thickness])
                top_panel();
        }
        
        stacking_slab();
    }
}

// === RENDERING ===

cable_insert();
