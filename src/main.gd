extends Node2D

var mouse_pos: Vector2;
var grid: Grid;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = get_node("Grid");
	print(grid.position);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
