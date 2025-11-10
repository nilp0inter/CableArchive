// Cable Archive - Organizador paramétrico de cables
// ================================================
// Diseño modular: cada inserto puede apilarse con otros para cubrir cajones completos

// === PARÁMETROS DEL INSERTO ===

// Dimensiones del panel (donde se sitúa la ranura)
panel_width = 50;       
panel_height = 30;
panel_thickness = 3;

// Márgenes de la ranura respecto a los bordes del panel
margin_horizontal = 5;
margin_vertical = 5;

// Parámetros de la ranura para cables (forma de chupa-chups)
enable_main_slot = true;
slot_width = 3;
entry_diameter = 15;
end_rounding = true;

// Ranuras perpendiculares opcionales
enable_perpendicular_slots = true;
perpendicular_slot_spacing = 15;
perpendicular_slot_end_radius = 2;

// Parámetros de la base (paredes)
wall_height = 20;
wall_thickness = 2;
cross_margin_width = 5;
cross_margin_height = 5;
cross_margin_top = 2;

// Dimensiones calculadas
slot_length = panel_width - 2*margin_horizontal - entry_diameter/2 - slot_width/2;
cross_width_horizontal = panel_height - 2*cross_margin_height;
cross_width_vertical = panel_width - 2*cross_margin_width;
num_perpendicular_slots = floor(slot_length / perpendicular_slot_spacing);

$fn = 50;      

// === MÓDULOS ===

module panel() {
    cube([panel_width, panel_height, panel_thickness]);
}

module walls() {
    difference() {
        cube([panel_width, panel_height, wall_height]);
        
        translate([wall_thickness, wall_thickness, -1])
            cube([panel_width - 2*wall_thickness, panel_height - 2*wall_thickness, wall_height + 2]);
    }
}

module cross_cutout() {
    cutout_height = wall_height - cross_margin_top + 2;
    
    union() {
        translate([-1, cross_margin_height, -1])
            cube([panel_width + 2, cross_width_horizontal, cutout_height]);
        
        translate([cross_margin_width, -1, -1])
            cube([cross_width_vertical, panel_height + 2, cutout_height]);
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
        translate([0, 0, 0])
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
    available_height_above = panel_height/2 - margin_vertical;
    available_height_below = panel_height/2 - margin_vertical;
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
        for (i = [1:num_perpendicular_slots]) {
            x_pos = i * perpendicular_slot_spacing;
            
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
                
                translate([margin_horizontal + entry_diameter/2, panel_height/2, -1])
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

// === RENDERIZADO ===

cable_insert();
