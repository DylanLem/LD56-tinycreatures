extends Sprite2D


enum Shape {}


var default_position;
var toggle_button_default_position;

var game: Main;


func _ready() -> void:
	default_position = self.position
	toggle_button_default_position = $ToggleButton.position
	
	game = get_parent()


func _process(delta: float) -> void:
	var building_cost_label: Label = $PlaceIcon/Label
	var skip_button_label: Label = $SkipButton/Label
	var mode_button_label: Label = $ModeButton/Label
	
	building_cost_label.text = str(Global.place_building_cost)
	skip_button_label.text = str(Global.skip_building_cost)
	mode_button_label.text = str(Global.delete_cluster_cost)
	
	if Global.resources < Global.place_building_cost:
		building_cost_label.modulate = Color.RED
	else:
		building_cost_label.modulate = Color.GREEN
	
	if Global.resources < Global.skip_building_cost:
		skip_button_label.modulate = Color.RED
	else:
		skip_button_label.modulate = Color.GREEN
	
	if Global.resources < Global.delete_cluster_cost:
		mode_button_label.modulate = Color.RED
	else:
		mode_button_label.modulate = Color.GREEN


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	if(!toggled_on):
		self.position.y = default_position.y;
		$ToggleButton.position.y = toggle_button_default_position.y
		$ToggleButton.flip_v = false
	else:
		self.position.y += 42;
		$ToggleButton.position.y -= 7
		$ToggleButton.flip_v = true
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	get_parent().get_node("SoundEffects").stream = get_parent().sfx["skip"]
	get_parent().get_node("SoundEffects").play()

	if Global.resources >= Global.skip_building_cost:
		game.advance_building()
		Global.increment_buildings_skipped()
	else:
		$SkipButton/Label/ShakeTimer.start()
