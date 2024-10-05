class_name Cluster

var cells: Array[Cell];

var type: Building.BuildingType = Building.BuildingType.None;

var size: int : 
	get:
		return cells.size();


func assimilate_cluster(cluster: Cluster):
	if(cluster.type != self.type):
		print("attempted to merge clusters of different type: ", self.type, " to ", cluster.type)
		
	for cell in cluster.cells:
		cell.cluster = self;
	cells.append_array(cluster.cells)
	cluster.cells.clear();
	pass;
