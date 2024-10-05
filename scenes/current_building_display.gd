extends Control


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var building: Building = get_parent().get_parent().current_building
	
	for r in building.get_n_rows():
		for c in building.get_n_cols():
			var color = Cell.get_color(building.cells[r][c])
			draw_rect(Rect2i(
				(Global.cell_size+1) * c + size.x / 2 - building.get_width() / 2,
				(Global.cell_size+1) * r + size.y / 2 - building.get_height() / 2,
				Global.cell_size,
				Global.cell_size
			), color)
