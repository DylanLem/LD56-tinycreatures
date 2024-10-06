class_name Building extends Node2D

enum BuildingType {
	Default = -2,
	Invalid = -1,
	None,
	Resources,
	Population,
	Attack,
	Defense,
	Efficiency,
	Speed,
}

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
		[1,1,2],
	],
	[
		[1,1,1,1],
	],
	[
		[1,1,2,2],
	],
	[
		[1,1],
		[1,1],
	],
	[
		[1,1],
		[1,2],
	],
	[
		[1,2],
		[1,2],
	],
	[
		[1,1],
		[1,0],
	],
	[
		[1,1],
		[2,0],
	],
	[
		[1,2],
		[2,0],
	],
	[
		[1,1,1],
		[1,0,1],
	],
	[
		[1,2,2],
		[1,0,2],
	],
	[
		[1,1,1],
		[0,1,0],
	],
	[
		[1,1,2],
		[0,1,0],
	],
	[
		[1,1,1],
		[0,2,0],
	],
	[
		[1,1,1],
		[1,1,0],
		[1,0,0],
	],
	[
		[1,2,2],
		[1,2,0],
		[1,0,0],
	],
	[
		[0,0,1],
		[1,0,1],
		[1,1,1],
	],
	[
		[0,0,2],
		[1,0,2],
		[1,1,2],
	],
	[
		[1,0,0],
		[1,0,0],
		[1,1,1],
	],
	[
		[1,0,0],
		[1,0,0],
		[1,2,2],
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


func get_width() -> int:
	return get_n_cols() * (Global.cell_size+1) - 1


func get_height() -> int:
	return get_n_rows() * (Global.cell_size+1) - 1


func rotate_clockwise() -> void:
	var new_cells: Array[Array] = []
	
	for c in range(get_n_cols()):
		var new_row = []
		for r in range(get_n_rows()):
			new_row.append(cells[r][c])
		new_row.reverse()
		new_cells.append(new_row)
	
	cells = new_cells


static func get_shape(n: int):
	var shape = shapes[n].duplicate(true)
	
	var one = get_random_buildingtype()
	var two = get_random_buildingtype()
	var three = get_random_buildingtype()
	
	for r in range(shape.size()):
		for c in range(shape[0].size()):
			if shape[r][c] == 1:
				shape[r][c] = one
			elif shape[r][c] == 2:
				shape[r][c] = two
			elif shape[r][c] == 3:
				shape[r][c] = three
			else:
				shape[r][c] = BuildingType.None
	
	return shape


static func get_random_shape():
	return get_shape(randi_range(0, shapes.size()-1));


static func get_random_buildingtype() -> BuildingType:
	var valid_buildingtypes = BuildingType.values()
	valid_buildingtypes.erase(BuildingType.Default)
	valid_buildingtypes.erase(BuildingType.Invalid)
	valid_buildingtypes.erase(BuildingType.None)
	#valid_buildingtypes.erase(BuildingType.Defense)
	return valid_buildingtypes.pick_random()


func draw():
	for r in get_n_rows():
		for c in get_n_cols():
			pass
