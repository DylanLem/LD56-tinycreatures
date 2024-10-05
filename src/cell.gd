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
		Building.BuildingType.None:
			return Color.TRANSPARENT
		Building.BuildingType.Resources:
			return Color.DARK_GREEN
		Building.BuildingType.Attack:
			return Color.FIREBRICK
	
	return Color.BLACK
	
	
	
func on_board_placement():
	var neighbours = [grid.get_neighbour(self, Grid.Direction.North), 
					  grid.get_neighbour(self, Grid.Direction.East),
					  grid.get_neighbour(self, Grid.Direction.South),
					  grid.get_neighbour(self, Grid.Direction.West)]
	
	var matching_neighbours = [];		
					
	for neighbour in neighbours:
		if(neighbour.type == self.type):
			matching_neighbours.add(neighbour)
		pass;
	
	match matching_neighbours.size():
		0:
			var clussy = Cluster.new();
			clussy.type = self.type;
			clussy.cells.append(self);
			self.cluster = clussy
			
			
		1:
			self.cluster = matching_neighbours[0].cluster
			
			
		var poly_match:
			var clussy = Cluster.new();
			clussy.type = self.type;
			clussy.cells.append(self);
			
		
			for matched in matching_neighbours:
				if(matched.cluster == self.cluster):
					continue;
				clussy.assimilate_cluster(matched.cluster)
			self.cluster = clussy;
		
		
	pass;
