class_name Main extends Node2D


var mouse_pos: Vector2;
var grid: Grid;
var current_building: Building


func _ready() -> void:
	grid = get_node("Grid");
	
	current_building = null
	randomize_building()
	
	pass # Replace with function body.


func _process(delta: float) -> void:
	grid.update(delta)
	
	if Input.is_action_just_pressed("right_click"):
		current_building.rotate_clockwise()
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	var mouse_pos = grid.mouse_grid_pos
	
	if mouse_pos.x >= 0 and \
	mouse_pos.x < grid.columns and \
	mouse_pos.y >= 0 and \
	mouse_pos.y < grid.rows:
		var building_cells = []
		
		var valid_position = true
		
		for r in range(current_building.get_n_rows()):
			for c in range(current_building.get_n_cols()):
				var building_row = clamp(mouse_pos.y - floor(current_building.get_n_rows() / 2.0), 0, (grid.rows-1) - current_building.get_n_rows() + 1) + r
				var building_col = clamp(mouse_pos.x - floor(current_building.get_n_cols() / 2.0), 0, (grid.columns-1) - current_building.get_n_cols() + 1) + c
				
				var cell = grid.contents[building_row][building_col]
				
				var building_cell = current_building.cells[r][c]
				
				
				if cell.type != Building.BuildingType.None and \
				building_cell != Building.BuildingType.None:
					cell.show_deny_placing = true
					valid_position = false
				elif building_cell != Building.BuildingType.None:
					cell.highlight(building_cell)
					building_cells.append(cell)
		
		var has_neighbour = false
		for cell in building_cells:
			if has_neighbour: break
			for neighbour in cell.get_neighbours():
				if neighbour.type != Building.BuildingType.None:
					has_neighbour = true
					break
		
		if not has_neighbour:
			for cell in building_cells:
				#cell.show_deny_placing = true
				pass
		
		if valid_position and has_neighbour:
			if Input.is_action_just_pressed("left_click"):
				if PlayerData.resources >= Global.place_building_cost:
					for cell in building_cells:
						cell.type = cell.highlight_type
						if(cell.type != Building.BuildingType.None):
							cell.on_board_placement()
					randomize_building()
					PlayerData.resources -= Global.place_building_cost
				
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	$ResourcesLabel.text = str(int(PlayerData.resources))


func randomize_building() -> void:
	current_building = Building.new()


func _on_resource_production_timer_timeout() -> void:
	PlayerData.resources += PlayerData.resource_production
