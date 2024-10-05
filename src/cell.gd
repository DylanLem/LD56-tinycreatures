class_name Cell extends Node2D

var row: int = 0
var column: int = 0

var type: Building.BuildingType = Building.BuildingType.None;

var highlighted: bool = false
var highlight_type: Building.BuildingType = Building.BuildingType.None


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
