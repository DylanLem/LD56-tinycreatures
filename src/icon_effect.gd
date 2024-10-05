class_name IconEffect extends Sprite2D

var life_time:float =  1.5;

var timer:Timer;

var speed = 3.0;
var trajectory: Vector2;
var spawn_offset:int;

var anthill;

var sub_position: Vector2;

var type: Building.BuildingType;


static var sprites: Array[Texture] = [
	preload("res://sprites/efficiency_icon.png"),
	preload("res://sprites/population_icon.png"),
	preload("res://sprites/resource_icon.png"),
	preload("res://sprites/speed_icon.png"),
	preload("res://sprites/shield_icon.png"),
	preload("res://sprites/attack_icon.png"),
]




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trajectory = Vector2(randf_range(-0.5,0.5), -speed);
	spawn_offset = randi_range(-5,5);
	
	anthill = get_parent().get_node("Anthill");
	
	self.position = anthill.position;
	self.position.x += spawn_offset;
	self.sub_position = self.position;
	
	timer = Timer.new();
	add_child(timer);
	timer.wait_time = life_time;
	timer.timeout.connect(die);
	timer.start();
	
	map_sprite(self.type)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sub_position += trajectory*delta;
	
	self.position = Vector2(int(sub_position.x),int(sub_position.y));
	self.modulate.a = timer.time_left/ self.life_time;
	
	pass
	
func die():
	queue_free();


func map_sprite(b_type: Building.BuildingType):
	
	match(b_type):
		Building.BuildingType.Attack:
			self.texture = self.sprites[5];
		Building.BuildingType.Defense:
			self.texture = self.sprites[4];
		Building.BuildingType.Resources: 
			self.texture = self.sprites[2];
		Building.BuildingType.Population:
			self.texture = self.sprites[1];
		Building.BuildingType.Efficiency:
			self.texture = self.sprites[0];
		Building.BuildingType.Speed:
			self.texture = self.sprites[3];
