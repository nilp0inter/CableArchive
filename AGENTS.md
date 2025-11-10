# Agent Guidelines for Cable Archive

## Build/Test Commands
- **Render**: Open `cable_archive.scad` in OpenSCAD and press F6
- **Export STL**: After rendering, use File > Export > Export as STL
- **No automated tests**: This is a pure OpenSCAD design project

## Code Style (OpenSCAD)
- Use snake_case for all variables, parameters, and module names
- Group parameters in customizer sections using `/* [Section Name] */`
- Add descriptive comments for main sections using `// === SECTION ===`
- Keep calculated values separate and mark as "DO NOT EDIT"
- Set rendering quality with `$fn` parameter (currently 50)
- Use meaningful parameter names that describe physical dimensions
- Indent with 4 spaces, not tabs
- Keep module definitions organized: simple shapes first, complex compositions last
- Use `difference()` and `union()` for boolean operations
- Always include units context in comments (implicitly mm for this project)
- Use `linear_extrude()` for 2D to 3D conversions
- End files with main rendering call (e.g., `cable_insert();`)

## Project Structure
- Single file design: `cable_archive.scad`
- Parametric design: all dimensions configurable via parameters
- Spanish documentation in README.md, English comments in code
