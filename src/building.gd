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

static var valid_buildingtypes: Array = []

static func _static_init() -> void:
	valid_buildingtypes = BuildingType.values()
	valid_buildingtypes.erase(BuildingType.Default)
	valid_buildingtypes.erase(BuildingType.Invalid)
	valid_buildingtypes.erase(BuildingType.None)
	valid_buildingtypes.erase(BuildingType.Speed)

#describes the cells that make up this building
var shape;

static var shapes = [
	#[
		#[1],
	#],
	[
		[1,1],
	],
	[
		[1,1,1],
	],
	#[
		#[1,1,2],
	#],
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
	#[
		#[1,1],
		#[1,2],
	#],
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
		[1,0],
	],
	#[
		#[1,1,1],
		#[1,0,1],
	#],
	#[
		#[1,2,2],
		#[1,0,2],
	#],
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
	#[
		#[1,1,1],
		#[1,1,0],
	#],
	[
		[1,2,2],
		[1,1,0],
	],
	[
		[2,1,0],
		[2,1,1],
	],
	[
		[1,2,2],
		[1,2,0],
		[1,0,0],
	],
	[
		[1,1],
		[2,0],
		[2,0],
	],
	[
		[2,2],
		[0,1],
		[0,1],
	],
	[
		[1,1,1],
		[0,2,0],
		[0,2,0],
	],
	#[
		#[0,0,1],
		#[1,0,1],
		#[1,1,1],
	#],
	#[
		#[0,0,2],
		#[1,0,2],
		#[1,1,2],
	#],
	#[
		#[1,0,0],
		#[1,0,0],
		#[1,1,1],
	#],
	#[
		#[1,0,0],
		#[1,0,0],
		#[1,2,2],
	#],
]


func _init() -> void:
	shape = get_random_shape()


func _process(delta: float) -> void:
	pass


func get_n_rows() -> int:
	return shape.size()


func get_n_cols() -> int:
	return shape[0].size()


func get_width() -> int:
	return get_n_cols() * (Global.cell_size+1) - 1


func get_height() -> int:
	return get_n_rows() * (Global.cell_size+1) - 1


func rotate_clockwise() -> void:
	var new_shape: Array[Array] = []
	
	for c in range(get_n_cols()):
		var new_row = []
		for r in range(get_n_rows()):
			new_row.append(shape[r][c])
		new_row.reverse()
		new_shape.append(new_row)
	
	shape = new_shape


static func get_shape(n: int):
	var shape = shapes[n].duplicate(true)
	
	var one = get_random_buildingtype()
	var two = get_random_buildingtype()
	
	for r in range(shape.size()):
		for c in range(shape[0].size()):
			var cell_type = shape[r][c]
			
			match cell_type:
				1:
					shape[r][c] = one
				2:
					shape[r][c] = two
				_:
					shape[r][c] = BuildingType.None
	
	return shape


static func get_random_shape():
	return get_shape(randi_range(0, shapes.size()-1));


static func get_random_buildingtype() -> BuildingType:
	return valid_buildingtypes.pick_random()
