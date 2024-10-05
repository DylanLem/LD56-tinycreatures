extends Node2D

var mouse_pos: Vector2;
var grid: Grid;

var current_building: Building


func _ready() -> void:
	grid = get_node("Grid");
	print(grid.position);
	
	current_building = Building.new()
	
	pass # Replace with function body.


func _process(delta: float) -> void:
	grid.update(delta)
	
	var mouse_pos = grid.mouse_grid_pos
	
	for r in range(current_building.get_n_rows()):
		for c in range(current_building.get_n_cols()):
			
			var building_row = clamp(mouse_pos.y - floor(current_building.get_n_rows() / 2.0), 0, 14 - current_building.get_n_rows() + 1) + r
			var building_col = clamp(mouse_pos.x - floor(current_building.get_n_cols() / 2.0), 0, 14 - current_building.get_n_cols() + 1) + c
			
			if current_building.cells[r][c] == 1:
				grid.contents[building_col][building_row].color = Color.WHITE
