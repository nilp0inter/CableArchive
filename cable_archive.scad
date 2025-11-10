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
slot_width = 3;
entry_diameter = 15;
end_rounding = true;

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

module cable_insert() {
    union() {
        translate([0, 0, wall_height])
            difference() {
                panel();
                
                translate([margin_horizontal + entry_diameter/2, panel_height/2, -1])
                    linear_extrude(height = panel_thickness + 2)
                        cable_slot();
            }
        
        base();
    }
}

// === RENDERIZADO ===

cable_insert();
