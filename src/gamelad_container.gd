extends Sprite2D

var interior_moused: bool = false;
var container_moused: bool = false;

var mouse_pos: Vector2;
var prev_mouse_pos: Vector2;

var mouse_down = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_pos = Vector2i(get_viewport().get_mouse_position()) + get_viewport().position;
	prev_mouse_pos =Vector2i(get_viewport().get_mouse_position()) + get_viewport().position;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	mouse_pos = Vector2i(get_viewport().get_mouse_position()) + get_viewport().position;
	if(container_moused and not interior_moused):
		
		
		if Input.is_action_just_pressed("left_click"):
			mouse_down = true;
	
	if(mouse_down):	
		if Input.is_action_pressed("left_click"):
			get_viewport().position += Vector2i(mouse_pos - prev_mouse_pos);			
		else:
			mouse_down = false;
			
	prev_mouse_pos = mouse_pos;
	pass


func _on_interior_mouse_entered() -> void:
	interior_moused = true;
	pass # Replace with function body.


func _on_container_mouse_entered() -> void:
	container_moused = true;
	pass # Replace with function body.

func _on_interior_mouse_exited() -> void:
	interior_moused = false;
	pass # Replace with function body.

func _on_container_mouse_exited() -> void:
	container_moused = false;
	pass # Replace with function body.
