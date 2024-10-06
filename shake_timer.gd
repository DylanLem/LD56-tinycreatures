extends Timer


var parent
var default_position: Vector2


func _ready() -> void:
	parent = get_parent()
	default_position = parent.position


func _process(delta: float) -> void:
	if not is_stopped():
		parent.position = default_position + Vector2(
			randi_range(-1, 1),
			randi_range(-1, 1)
		)
	else:
		parent.position = default_position
