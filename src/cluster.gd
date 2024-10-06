class_name Cluster

var cells: Array[Cell];

var type: Building.BuildingType = Building.BuildingType.None;

var multiplier: float = 1.0;

var prev_multiplier: float = 1.0;

var cell_val: float = 0.005;

var scaling:float =  1.5;
var soft_cap:float = 2.0;

var size: int : 
	get:
		return cells.size();


func assimilate_cluster(cluster: Cluster):
	if(cluster.type != self.type):
		print("attempted to merge clusters of different type: ", self.type, " to ", cluster.type)
	
	print("I am size before: ",  self.cells.size())
	for cell in cluster.cells:
		cell.cluster = self;
		if(! self.cells.has(cell)):
			print("mergin clussy")
			self.cells.append(cell)
	#cluster.cells.clear();
	print("I am size after: ", self.cells.size())
	pass;

func calculate_multiplier():
	var premul = 1 + (size * cell_val) * size;
	var final = premul;
	if(premul >= soft_cap):
		var excess = premul - soft_cap;
		excess = pow(excess, 1./scaling)
		final = soft_cap + excess;
		
	multiplier = final;
	print("multi is now: " , multiplier, " for " , Building.BuildingType.find_key(type))

func update_cluster():
	prev_multiplier = multiplier;
	calculate_multiplier();
	
	Global.update_stat(self.type, multiplier - prev_multiplier);
	#for key in Global.stat_map:
		#print("UPDATING STATS:")
		#print(Building.BuildingType.find_key(key), ": " , Global.stat_map[key])
