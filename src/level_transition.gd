extends Sprite2D

var tooltips = ["Each colour provides different bonuses to your ants.", "one big cluster is FAR better than many small clusters.", "termites aren't very smart.", "this game was made in 3 days",\
"Try Lighthouse II!", "Be careful when deleting, disabled clusters are useless.", "yellow production boosts everything", "Extra ants and termites will garrison in their bases."]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LevelNum.text = "Level " + str(Global.current_level);
	$Tooltip.text = tooltips.pick_random();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_level_pressed() -> void:
	Global.current_level += 1;
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.
