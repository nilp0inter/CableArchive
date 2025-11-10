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

// Dimensiones calculadas
slot_length = panel_width - 2*margin_horizontal - entry_diameter/2 - slot_width/2;

$fn = 50;      

// === MÓDULOS ===

module panel() {
    cube([panel_width, panel_height, panel_thickness]);
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
    difference() {
        panel();
        
        translate([margin_horizontal + entry_diameter/2, panel_height/2, -1])
            linear_extrude(height = panel_thickness + 2)
                cable_slot();
    }
}

// === RENDERIZADO ===

cable_insert();
