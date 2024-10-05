class_name Cluster

var cells: Array[Cell];

var type: Building.BuildingType = Building.BuildingType.None;

var multiplier: float :
	get:
		return calculate_multiplier();
		
		
var cell_val: float = 0.1;

var scaling:float =  1.5;
var soft_cap:float = 2.0;

var size: int : 
	get:
		return cells.size();


func assimilate_cluster(cluster: Cluster):
	if(cluster.type != self.type):
		print("attempted to merge clusters of different type: ", self.type, " to ", cluster.type)
	
	
	for cell in cluster.cells:
		cell.cluster = self;
		if(! self.cells.has(cell)):
			self.cells.append(cell)
	
	pass;

func calculate_multiplier() -> float:
	var premul = 1 + (size * cell_val);
	var final = premul;
	if(premul >= soft_cap):
		var excess = premul - soft_cap;
		excess = pow(excess, 1./scaling)
		final = excess;
	return final;
	 
