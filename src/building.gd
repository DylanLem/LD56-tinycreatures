class_name Building extends Node2D

enum BuildingType {Resources, Population, Attack, Defense, Efficiency, Speed}

#describes the cells that make up this building
var cells: Array[Array];

var type: BuildingType;



func _init() -> void:
	cells = [
		[1,1,1],
		[1,0,1],
		[1,0,1],
		[1,0,1]
	]
	#cells = [
		#[1,1],
		#[1,0],
	#]


func _process(delta: float) -> void:
	pass


func get_n_rows() -> int:
	return cells.size()


func get_n_cols() -> int:
	return cells[0].size()
