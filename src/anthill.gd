extends Sprite2D

var ant_cost: int = 5;

#each "ant" is denoted by a single integer point which is its x-position;
var ants: Array[Ant];

var spawn_timer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = Timer.new();
	spawn_timer.wait_time = float(ant_cost/Global.ant_production)
	spawn_timer.timeout.connect(spawn_ant);
	add_child(spawn_timer)
	spawn_ant()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent: Node2D = get_parent();
	var ant_pos: Array;
	
	
	if ants.size() > 0 && ants.front().pos > get_parent().get_node("TermiteHole").position.x:
		ants.pop_front()
		
	var closest_termite = get_parent().get_node("TermiteHole").termites.front() if get_parent().get_node("TermiteHole").termites.size() >0 else null
	if closest_termite != null && ants.front() != null && ants.front().pos >= closest_termite.pos -1:
		closest_termite.hp -= ants.front().damage * delta;
		ants.front().sub_pos -= Global.ant_speed*delta;
		ants.front().pos = floor(ants.front().sub_pos);
		
	for ant in ants:
		var next_ant_index = ants.find(ant) - 1;
		if(next_ant_index >=0):
			if ants[next_ant_index].pos > ant.pos+1:
				ant.sub_pos += Global.ant_speed*delta;
				ant.pos = floor(ant.sub_pos);
		else:
			ant.sub_pos += Global.ant_speed*delta;
			ant.pos = floor(ant.sub_pos);
		
		ant_pos.append(ant.pos)
		

	var ant_hps: Array[float] = []
	var dead_ants: Array[Ant] = []
	
	for ant in ants:
		if(ant.hp <= 0):
			dead_ants.append(ant);
		else:
			ant_hps.append(ant.hp)
			
			
	for dead_ant in dead_ants:
		ants.erase(dead_ant);
	
	parent.get_node("Creatures").material.set_shader_parameter("ant_hp", ant_hps)
	parent.get_node("Creatures").material.set_shader_parameter("ants",ant_pos)
	pass

func reset_timer():
	spawn_timer.wait_time = float(ant_cost/Global.ant_production)
	spawn_timer.start();
	
	
func spawn_ant():
	var ant = Ant.new(true);
	ant.pos = $Spawnpoint.position.x + self.position.x;
	ant.sub_pos = ant.pos;
	ants.append(ant);
	get_parent().get_node("Creatures").material.set_shader_parameter("ant_max_hp", Global.ant_defense)
	reset_timer();
	#ANTSS!!!!!! (ANT = Annihilator of Nonfriendly Termites)
	
