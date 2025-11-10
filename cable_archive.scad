// Cable Archive - Organizador paramétrico de cables
// ================================================

// === PARÁMETROS PRINCIPALES ===

// Dimensiones de la base (parte horizontal de la L)
base_length = 100;      
base_width = 30;        
base_height = 3;        

// Dimensiones de la pared (parte vertical de la L)
wall_height = 50;       
wall_thickness = 3;     

// Parámetros de la ranura para cables
slot_width = 3;         
slot_depth = 2;         
slot_length = 40;       

// Entrada ensanchada
entry_width = 15;       
entry_length = 10;      

// Número de ranuras
num_slots = 5;          
slot_spacing = 15;      

// === MÓDULOS ===

module l_shape() {
    union() {
        cube([base_length, base_width, base_height]);
        
        translate([0, base_width - wall_thickness, 0])
            cube([base_length, wall_thickness, wall_height]);
    }
}

module cable_slot(with_entry=true) {
    union() {
        translate([0, -slot_depth, 0])
            cube([slot_length, slot_depth, slot_width]);
        
        if (with_entry) {
            translate([0, -slot_depth, 0])
                cube([entry_length, slot_depth, entry_width]);
        }
    }
}

module cable_archive() {
    difference() {
        l_shape();
        
        for (i = [0:num_slots-1]) {
            translate([i * slot_spacing + 10, base_width, base_height + 5])
                rotate([90, 0, 0])
                    cable_slot();
        }
    }
}

// === RENDERIZADO ===

cable_archive();
