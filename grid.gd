extends Node2D

enum Direction {North, South, East, West}

var width: int;
var height: int;

var contents: Array[Array];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_grid():
	pass;
	
func get_neighbour(cell: Cell, direction: Direction) -> Cell:
	
	return Cell.new();
