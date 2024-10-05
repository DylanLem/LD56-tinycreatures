extends Sprite2D

enum Shape {}


var default_position;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_position = self.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	if(!toggled_on):
		self.position.y = default_position.y;
	else:
		self.position.y += 15;
	pass # Replace with function body.
