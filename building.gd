class_name Building extends Node2D

enum BuildingType {Resources, Population, Attack, Defense, Efficiency, Speed}

#describes the cells that make up this building
var cells: Array[Cell];

var type: BuildingType;


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
