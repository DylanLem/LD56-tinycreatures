extends Sprite2D

var building: Building;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	building = Building.new();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw();
	pass

func _draw():
	print(building, ": " , building.get_n_rows(), ", ", building.get_n_cols())
	for r in building.get_n_rows():
		for c in building.get_n_cols():
			var color = Cell.get_color(building.cells[r][c])
			draw_rect(Rect2i(
				(Global.cell_size/ self.transform.get_scale().x+1) * c + (self.texture.get_width() * self.transform.get_scale().x  / 2) - building.get_width() / 2,
				(Global.cell_size/ self.transform.get_scale().y+1) * r + (self.texture.get_height()* self.transform.get_scale().y   / 2) - building.get_height() / 2,
				Global.cell_size / self.transform.get_scale().x,
				Global.cell_size / self.transform.get_scale().y
			), color)
