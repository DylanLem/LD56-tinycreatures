extends Sprite2D


enum Shape {}


var default_position;

var game: Main;


func _ready() -> void:
	default_position = self.position
	
	game = get_parent()


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	if(!toggled_on):
		self.position.y = default_position.y;
	else:
		self.position.y += 15;
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	if PlayerData.resources >= Global.skip_building_cost:
		game.randomize_building()
		PlayerData.resources -= Global.skip_building_cost
