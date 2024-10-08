extends Sprite2D


var get_building: Callable = func(): return null


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	#var building: Building = get_parent().get_parent().next_building
	var building: Building = get_building.call()
	
	if building == null: return
	
	for r in building.get_n_rows():
		for c in building.get_n_cols():
			var color = Cell.get_color(building.shape[r][c])
			draw_rect(Rect2i(
				(Global.cell_size+1) * c - building.get_width()  / 2,
				(Global.cell_size+1) * r - building.get_height() / 2,
				Global.cell_size,
				Global.cell_size
			), color)
