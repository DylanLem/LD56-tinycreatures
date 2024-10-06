extends Sprite2D

#this could really just be a copy of the anthill node, but maybe theres a flag for going left instead of right

var termites: Array[Ant];

var spawn_timer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = Timer.new();
	spawn_timer.wait_time = float(1./Global.termite_production)
	spawn_timer.timeout.connect(spawn_termite);
	add_child(spawn_timer)
	spawn_termite()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent: Node2D = get_parent();
	var termite_pos: Array;
	
	var is_stuck: Array[bool]
	
	
	if termites.size()>0 && termites.front().pos < get_parent().get_node("Anthill").position.x:
		termites.pop_front()
		
	var closest_ant = get_parent().get_node("Anthill").ants.front()
	if closest_ant != null && termites.front() != null && \
	termites.front().pos <= closest_ant.pos:
		closest_ant.hp -= termites.front().damage * delta; 
		termites.front().sub_pos -= Global.termite_speed*delta;
		termites.front().pos = floor(termites.front().sub_pos);
	
	for termite in termites:
		termite_pos.append(termite.pos)
		termite.sub_pos += Global.termite_speed*delta;
		termite.pos = floor(termite.sub_pos);
	
	var termite_hps: Array[float] = []
	var dead_termites: Array[Ant] = []
	for termite in termites:
		if(termite.hp <= 0):
			dead_termites.append(termite);
		else:
			termite_hps.append(termite.hp)
	for dead_termite in dead_termites:
		termites.erase(dead_termite);
	
	parent.get_node("Creatures").material.set_shader_parameter("termite_hp", termite_hps)
	
	parent.get_node("Creatures").material.set_shader_parameter("termites",termite_pos)
	pass

func spawn_termite():
	var termite = Ant.new(false);
	termite.pos = $Spawnpoint.position.x + self.position.x;
	termite.sub_pos = termite.pos;
	termites.append(termite);
	get_parent().get_node("Creatures").material.set_shader_parameter("termite_max_hp", Global.termite_defense)
	reset_timer();
	#TERMITE : TOTALLY EVIL, REALLY MALICIOUS, INSUFFERABLE and TERRIBLE ENIGMA

func reset_timer():
	spawn_timer.wait_time = float(Global.termite_production)
	spawn_timer.start();
	
