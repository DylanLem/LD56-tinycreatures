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
	$BuildingCost.text = "cost:" + str(Global.place_building_cost)
	$SkipButton.text = "skip:" + str(Global.skip_building_cost)


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	if(!toggled_on):
		self.position.y = default_position.y;
		$ToggleButton.position.y = toggle_button_default_position.y
		$ToggleButton.flip_v = false
	else:
		self.position.y += 21;
		$ToggleButton.position.y -= 7
		$ToggleButton.flip_v = true
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	if Global.resources >= Global.skip_building_cost:
		game.randomize_building()
		Global.increment_buildings_skipped()
