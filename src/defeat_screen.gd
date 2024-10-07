extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for stat in Global.stat_map:
		Global.update_stat(stat, (-Global.stat_map[stat])+1)
	Global.current_level = 1;
	$DeathSound.play();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
	pass # Replace with function body.
