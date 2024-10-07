
extends Sprite2D

var clouds: Array[Sprite2D];
var cloud_velocities: Array[float];
var cloud_positions: Array[Vector2];
var cloudTimer:Timer;

@export var cloud_sprites: Array[Texture];

var night_time: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	cloudTimer = Timer.new();
	add_child(cloudTimer)
	cloudTimer.timeout.connect(Callable(self,"make_cloud"))
	cloudTimer.set_wait_time(float(randi_range(3,10)));
	cloudTimer.start();
	
	
	
	pass # Replace with function body.

func initialize_clouds():
	make_cloud()
	make_cloud()
	make_cloud()
	make_cloud()
	make_cloud()
	make_cloud()
	
	for i in range(cloud_positions.size()):
		cloud_positions[i].x += randi_range(1,128);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var popped_clouds: Array[int];
	
	for i in range(clouds.size()):
		cloud_positions[i].x += cloud_velocities[i] * delta;
		clouds[i].position = floor(cloud_positions[i]);
		if(clouds[i].position.x > get_window().content_scale_size.x + clouds[i].texture.get_width()):
			popped_clouds.append(i);
			
	for cloud in popped_clouds:
		clouds[cloud].queue_free();
		clouds.erase(clouds[cloud]);
		cloud_positions.erase(cloud_positions[cloud])
		cloud_velocities.erase(cloud_velocities[cloud])
	pass
	
	

func make_cloud():
	cloudTimer.stop();

	
	var cloud = Sprite2D.new();
	cloud.texture = cloud_sprites[randi_range(0,cloud_sprites.size()-1)]
	print("HI" , texture.resource_name)
	
	if(night_time):
		cloud.modulate = Color("ffa659d2");
	add_child(cloud);
	
	clouds.append(cloud);
	cloud_velocities.append(randf_range(0.15, 0.35))
	cloud.position = Vector2(- self.texture.get_width()/2 - cloud.texture.get_width()/2,randi_range(-self.texture.get_height()/2, self.texture.get_height()/2 - cloud.texture.get_height()))
	cloud_positions.append(cloud.position)
	
	
	cloudTimer.set_wait_time(float(randi_range(10,30)));
	cloudTimer.start();
	
	
