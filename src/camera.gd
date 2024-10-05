extends Camera2D

var min_zoom:float = 1.0;
var max_zoom:float = 4.0;

var zoom_factor:float = 0.25;
var current_zoom:float = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func do_zoom(direction: bool)-> void:
	if(direction):
		current_zoom += zoom_factor;
	else:
		current_zoom -= zoom_factor;
		
	current_zoom = clampf(current_zoom, min_zoom, max_zoom)
	set_zoom(Vector2(current_zoom,current_zoom));
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ZoomIn"):
		do_zoom(true);
	if event.is_action("ZoomOut"):
		do_zoom(false);
