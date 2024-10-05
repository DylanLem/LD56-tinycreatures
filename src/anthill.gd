extends Sprite2D

var ant_cost: int = 5;

#each "ant" is denoted by a single integer point which is its x-position;
var ants: Array[Ant];

var spawn_timer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = Timer.new();
	spawn_timer.wait_time = float(ant_cost/PlayerData.ant_production)
	spawn_timer.timeout.connect(spawn_ant);
	add_child(spawn_timer)
	spawn_ant()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent: Node2D = get_parent();
	var ant_pos: Array;
	for ant in ants:
		ant_pos.append(ant.pos)
		ant.sub_pos += PlayerData.ant_speed*delta;
		ant.pos = floor(ant.sub_pos);

	parent.get_node("Creatures").material.set_shader_parameter("ants",ant_pos)
	pass

func reset_timer():
	spawn_timer.wait_time = float(ant_cost/PlayerData.ant_production)
	spawn_timer.start();
	
	
func spawn_ant():
	var ant = Ant.new();
	ant.pos = $Spawnpoint.position.x + self.position.x;
	ant.sub_pos = ant.pos;
	ants.append(ant);
	reset_timer();
	#ANTSS!!!!!! (ANT = Annihilator of Nonfriendly Termites)
	
