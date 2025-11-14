# Cable Archive

A parametric cable organizer designed in OpenSCAD for 3D printing.

![Cable Archive](cable_archive.png)

## Description

Cable Archive is a modular insert that can be installed in drawers or containers to organize all types of cables. The design consists of a flat panel with perimeter walls and specialized slots for cable management. Optional fins provide additional separation between slots, and a bottom lid can enclose the organizer completely.

### Features

- **Main cable slot**: Allows the cable to pass through while retaining the connectors
- **Optional entry points**: Circular openings at both ends facilitate cable insertion
- **Per cable slots**: Multiple cross-slots for securing cables at various points
- **Visible storage**: Both connectors remain visible simultaneously
- **Easy extraction**: Simply pull the connectors to remove cables
- **Modular design**: Multiple inserts can be stacked to cover entire drawers
- **Cross-shaped cutout**: Base walls have cutouts for easy material access
- **Optional cable separators**: Vertical separators between perpendicular slots for enhanced organization
- **Optional bottom lid**: Base panel to fully enclose the organizer
- **Optional stacking slab**: Additional slab below the bottom lid for improved stackability
- **Optional stacking lip**: Raised edge around the top for better stacking alignment
- **Fully parametric**: Customizable to your specific needs

## Design Components

### Panel
- Flat top panel with main cable slot
- Default dimensions: 310mm × 60mm × 3mm (height × width × thickness)
- Optional stacking lip for improved stacking

### Base Walls
- Vertical walls around the perimeter (default 20mm height, 2mm thickness)
- Cross-shaped cutout pattern for material reduction
- Optional cable separators for additional separation between slots
- Optional bottom lid to enclose the organizer
- Optional stacking slab below the bottom lid for improved stackability

### Cable Separators
- Optional vertical separators positioned between perpendicular slots
- Configurable width and height percentage relative to wall height
- Optional upward extension for additional separation
- Cut by main slots and cross cutouts for integration

### Bottom Lid
- Optional base panel matching top panel dimensions
- Provides complete enclosure when enabled
- Positioned below the base walls

### Main Slot
- Circular entry (25mm diameter) for easy cable insertion
- Narrow channel (3mm wide) to retain connectors
- Optional rounded end for smooth cable routing
- Customizable margins and positioning

### Per Cable Slots
- Multiple slots perpendicular to the main slot
- Automatically calculated spacing (default 25mm)
- Rounded ends (3mm radius) for gentle cable guidance
- Can be enabled/disabled independently

## Usage

1. Open `cable_archive.scad` in OpenSCAD
2. Adjust parameters in the Customizer panel (Window > Customizer)
3. Press F5 for preview or F6 for full render
4. Export to STL: File > Export > Export as STL
5. 3D print with your preferred settings

## Customizable Parameters

### Top Panel
- `top_panel_width`: Width of the panel (default: 60mm)
- `top_panel_height`: Height/length of the panel (default: 310mm)
- `top_panel_thickness`: Thickness of the top panel (default: 3mm)

### Bottom Panel
- `bottom_panel_enabled`: Toggle bottom panel on/off (default: true)

### Walls
- `walls_height`: Height of perimeter walls (default: 20mm)
- `walls_thickness`: Thickness of the walls (default: 2mm)

### Stacking
- `stacking_slab_enabled`: Toggle stacking slab on/off (default: true, requires bottom lid enabled)
- `stacking_slab_padding`: Padding around stacking slab (default: 5mm)
- `stacking_slab_depth`: Thickness of stacking slab (default: 2mm)
- `stacking_lip_enabled`: Toggle top perimeter on/off (default: true)
- `stacking_lip_height`: Height of top perimeter (default: 5mm)
- `stacking_lip_padding`: Thickness of top perimeter walls (default: 2mm)

### Cross Cutout
- `cross_cutout_margin_width`: Horizontal margin for cutout (default: 5mm)
- `cross_cutout_margin_height`: Vertical margin for cutout (default: 5mm)
- `cross_cutout_margin_top`: Top margin to preserve (default: 2mm)

### Main Slot
- `main_slot_enabled`: Toggle main cable slot on/off (default: true)
- `main_slot_width`: Width of the cable channel (default: 3mm)
- `main_slot_primary_entry_diameter`: Diameter of the primary entry hole (default: 0mm)
- `main_slot_secondary_entry_diameter`: Diameter of the secondary entry hole (default: 0mm)
- `main_slot_margin`: Margin from panel edge (default: 10mm)

### Per Cable Slot
- `per_cable_slots_enabled`: Toggle perpendicular slots on/off (default: true)
- `per_cable_slot_spacing`: Distance between slots (default: 25mm)
- `per_cable_slot_width`: Width of the perpendicular slots (default: 3mm)
- `per_cable_slot_end_radius`: Radius of slot ends (default: 3mm)
- `per_cable_slot_margin`: Margin from panel edges (default: 5mm)
- `per_cable_slot_ends_minimum_margin`: Minimum margin from main slot ends (default: 10mm)

### Cable Separators
- `cable_separators_enabled`: Toggle fins on/off (default: true)
- `cable_separator_width`: Width of each fin (default: 2mm)
- `cable_separator_percentage`: Percentage of wall height fins occupy (default: 0.5)
- `cable_separator_extension`: Additional height to extend fins upwards (default: 0mm)

### Rendering
- `$fn`: Circle resolution (default: 50)

## Printing Recommendations

- **Layer height**: 0.2mm recommended
- **Infill**: 15-20% is sufficient
- **Supports**: Not required with proper orientation
- **Orientation**: Print with the panel facing up
- **Material**: PLA, PETG, or ABS work well

## License

Creative Commons
