class_name Cell extends Node2D

var row: int = 0
var column: int = 0

var type: Building.BuildingType = Building.BuildingType.None;


var highlighted: bool = false
var highlight_type: Building.BuildingType = Building.BuildingType.None

var show_x: bool = false

var grid: Grid;
var cluster: Cluster;


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func highlight(type: Building.BuildingType) -> void:
	highlighted = true;
	highlight_type = type


static func get_color(type: Building.BuildingType) -> Color:
	match type:
		Building.BuildingType.Default:
			return Color.BLACK
		Building.BuildingType.Invalid:
			return Color.BLACK
		Building.BuildingType.None:
			return Color.TRANSPARENT
		Building.BuildingType.Resources:
			return Color.CORAL
		Building.BuildingType.Population:
			return Color(0.767, 0.793, 0.6951, 1)
		Building.BuildingType.Attack:
			return Color(0.6406, 0.1898, 0.1898, 1)
		Building.BuildingType.Defense:
			return Color(0.102, 0.1686, 0.3569, 1)
		Building.BuildingType.Efficiency:
			return Color(0.9453, 0.9131, 0.4295, 1)
		Building.BuildingType.Speed:
			return Color(0.4231, 0.7539, 0.4039, 1)

	return Color.WHITE
	
	
	
func on_board_placement():
	var neighbours = get_neighbours()
	
	var matching_neighbours = [];		
	
	
	for neighbour in neighbours:
		if(neighbour.type == self.type):
			var midpoint = Vector2((neighbour.column + self.column)/ 2., (neighbour.row + self.row) /2.)
			if(! Global.colour_links.has(midpoint)):
				Global.colour_links.append(midpoint);
				Global.colour_link_colours.append(get_color(self.type))
				grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_links", Global.colour_links)
				grid.get_parent().get_node("Dirt").material.set_shader_parameter("colour_link_colours", Global.colour_link_colours)
			matching_neighbours.append(neighbour)
		pass;
	
	match matching_neighbours.size():
		0:
			var clussy = Cluster.new();
			clussy.type = self.type;
			clussy.cells.append(self);
			clussy.update_cluster();
			self.cluster = clussy
			
			
		1:
			if(matching_neighbours[0].cluster != null):
				self.cluster = matching_neighbours[0].cluster
				if(! matching_neighbours[0].cluster.cells.has(self)):
					matching_neighbours[0].cluster.cells.append(self)
					matching_neighbours[0].cluster.update_cluster();
					
			else:
				var clussy = Cluster.new();
				clussy.type = self.type;
				clussy.cells.append(self);
				clussy.cells.append(matching_neighbours[0])
				clussy.update_cluster();
				self.cluster = clussy
			
		var poly_match:			
			var clussy = Cluster.new();
			clussy.type = self.type;
			clussy.cells.append(self);
			
			var samecluster = false;
		
			for matched in matching_neighbours:
				
				if(matched.cluster == null) :
					matched.cluster = clussy;
					clussy.cells.append(matched)
					
					
				elif (matched.cluster == self.cluster):
					samecluster = true;
					continue;
					
				else:	
					clussy.assimilate_cluster(matched.cluster)

					
			if(not samecluster):
				self.cluster = clussy;
				clussy.update_cluster();
				
			else:
				self.cluster.assimilate_cluster(clussy)
				self.cluster.update_cluster();
		
	pass;


func get_draw_color() -> Color:
		if highlighted:
			return get_color(highlight_type)
		return get_color(type)


func get_neighbours() -> Array[Cell]:
	var n: Cell = grid.get_neighbour(self, Grid.Direction.North)
	var e: Cell = grid.get_neighbour(self, Grid.Direction.East)
	var s: Cell = grid.get_neighbour(self, Grid.Direction.South)
	var w: Cell = grid.get_neighbour(self, Grid.Direction.West)
	
	var result: Array[Cell] = []
	
	if n != null: result.append(n)
	if e != null: result.append(e)
	if s != null: result.append(s)
	if w != null: result.append(w)
	
	return result




func apply_multi() -> void:
	pass;



func clear() -> void:
	type = Building.BuildingType.None
	cluster = null
