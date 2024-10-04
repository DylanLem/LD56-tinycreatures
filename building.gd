class_name Building extends Node2D

enum BuildingType {Resources, Population, Attack, Defense, Efficiency, Speed}

#describes the cells that make up this building
var cells: Array[Cell];

var type: BuildingType;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
