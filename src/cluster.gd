class_name Cluster

var cells: Array[Cell];

var type: Building.BuildingType = Building.BuildingType.None;

var multiplier: float = 1.0;

var prev_multiplier: float = 1.0;

var cell_val: float = 0.005;

var scaling:float =  1.5;
var soft_cap:float = 2.0;

var enabled: bool = true


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


func disable() -> void:
	if not enabled: return
	
	enabled = false
	
	Global.update_stat(self.type, -multiplier)
	
	for cell in cells:
		cell.disabled = true
	
	erase_links()


func enable() -> void:
	if not enabled: Global.update_stat(self.type, multiplier)
	
	enabled = true
	
	for cell in cells:
		cell.disabled = false
	
	restore_links()


#func is_lone() -> bool:
	#var cell = cells[0]
	#var result = cell.grid.dijkstra(cell, cell.grid.root_cell)
	#
	#


func erase_links() -> void:
	for cell in cells:
		var neighbours = cell.get_neighbours()
		for neighbour in neighbours:
				if(neighbour.type == self.type):
					var midpoint = Vector2((neighbour.column + cell.column)/ 2., (neighbour.row + cell.row) /2.)
					if(Global.colour_links.has(midpoint)):
						var index = Global.colour_links.find(midpoint)
						Global.colour_links.erase(midpoint);
						Global.colour_link_colours.remove_at(index)
						cell.grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_links", Global.colour_links)
						cell.grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_link_colours", Global.colour_link_colours)


func restore_links() -> void:
	for cell in cells:
		var neighbours = cell.get_neighbours()
		for neighbour in neighbours:
				if(neighbour.type == self.type):
					var midpoint = Vector2((neighbour.column + cell.column)/ 2., (neighbour.row + cell.row) /2.)
					if(not Global.colour_links.has(midpoint)):
						Global.colour_links.append(midpoint);
						Global.colour_link_colours.append(cell.get_color(cell.type))
						cell.grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_links", Global.colour_links)
						cell.grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_link_colours", Global.colour_link_colours)


func delete() -> void:
	erase_links()
	for cell in cells:
		cell.clear()
