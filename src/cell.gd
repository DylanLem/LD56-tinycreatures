class_name Cell extends Node2D

var row: int = 0
var column: int = 0

var type: Building.BuildingType = Building.BuildingType.None;

var highlighted: bool = false
var highlight_type: Building.BuildingType = Building.BuildingType.None

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
		Building.BuildingType.Invalid:
			return Color.BLACK
		Building.BuildingType.None:
			return Color.TRANSPARENT
		Building.BuildingType.Resources:
			return Color.CORAL
		Building.BuildingType.Population:
			return Color.GREEN_YELLOW
		Building.BuildingType.Attack:
			return Color.DARK_RED
		Building.BuildingType.Defense:
			return Color.DARK_BLUE
		Building.BuildingType.Efficiency:
			return Color.GAINSBORO
		Building.BuildingType.Speed:
			return Color.SKY_BLUE

	print(type)

	return Color.WHITE
	
	
	
func on_board_placement():
	var neighbours = [grid.get_neighbour(self, Grid.Direction.North), 
					  grid.get_neighbour(self, Grid.Direction.East),
					  grid.get_neighbour(self, Grid.Direction.South),
					  grid.get_neighbour(self, Grid.Direction.West)]
	
	var matching_neighbours = [];		
	
	
	for neighbour in neighbours:
		if(neighbour == null):
			continue;
		if(neighbour.type == self.type):
			matching_neighbours.append(neighbour)
		pass;
	
	match matching_neighbours.size():
		0:
			var clussy = Cluster.new();
			clussy.type = self.type;
			clussy.cells.append(self);
			self.cluster = clussy
			
			
		1:
			if(matching_neighbours[0].cluster != null):
				self.cluster = matching_neighbours[0].cluster
				if(! matching_neighbours[0].cluster.cells.has(self)):
					matching_neighbours[0].cluster.cells.append(self)
			else:
				var clussy = Cluster.new();
				clussy.type = self.type;
				clussy.cells.append(self);
				clussy.cells.append(matching_neighbours[0])
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
			else:
				self.cluster.assimilate_cluster(clussy)
		
	pass;
