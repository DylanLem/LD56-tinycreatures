class_name Ant extends Node

var pos: int;
var sub_pos: float;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	sub_pos += PlayerData.ant_speed*delta;
	pos = floor(sub_pos);
	
	pass
