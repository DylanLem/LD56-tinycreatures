class_name Building extends Node2D

enum BuildingType {None, Invalid, Resources, Population, Attack, Defense, Efficiency, Speed}

#describes the cells that make up this building
var cells;

var type: BuildingType;

static var shapes = [
	[
		[1],
	],
	[
		[1,1],
	],
	[
		[1,1,1],
	],
	[
		[1,1],
		[1,1],
	],
	[
		[1,1],
		[1,0],
	],
	[
		[1,1,1],
		[1,0,1],
	],
	[
		[1,1,1],
		[0,1,0],
	],
	[
		[1,1,1],
		[1,1,0],
		[1,0,0],
	],
	[
		[0,0,1],
		[1,0,1],
		[1,1,1],
	],
	[
		[1,0,0],
		[1,0,0],
		[1,1,1],
	],
]



func _init() -> void:
	cells = get_random_shape()


func _process(delta: float) -> void:
	pass


func get_n_rows() -> int:
	return cells.size()


func get_n_cols() -> int:
	return cells[0].size()


func rotate_clockwise() -> void:
	var new_cells: Array[Array] = []
	
	for c in range(get_n_cols()):
		var new_row = []
		for r in range(get_n_rows()):
			new_row.append(cells[r][c])
		new_row.reverse()
		new_cells.append(new_row)
	
	cells = new_cells


static func get_random_shape():
	return shapes[randi_range(0, shapes.size()-1)]
