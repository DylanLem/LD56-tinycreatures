extends Node


const font_regular: Font = preload("res://furphyTiny.ttf")
const font_mono: Font = preload("res://furphyTiny.ttf")
const font_big_regular: Font = preload("res://furphySmall.ttf")


const cell_size: int = 3

var starting_resources: float = 1
var resources: float = 0

var resource_production: float = 0.5;

var ant_damage: float = 1.0;
var ant_defense: float = 1.0;
var termite_damage: float = 1.0;
var termite_defense: float = 1.0;


var efficiency: float = 1.0;


var ant_production: float = 1.0;
var termite_production: float = 1.0;

var ant_speed: float = 1.0;
var termite_speed: float = -2.0;

var building_placed: int = 0
var buildings_skipped: int = 0
var clusters_deleted: int = 0

var place_building_cost: int = 0
var skip_building_cost: int = 0
var delete_cluster_cost: int = 0

var colour_links: Array[Vector2];
var colour_link_colours: Array[Color];


var current_level = 1;


func _ready() -> void:
	initialize_values();

func initialize_values():
	building_placed = 0
	buildings_skipped= 0
	clusters_deleted = 0
	calculate_place_building_cost()
	calculate_skip_building_cost()
	calculate_delete_clusters_cost()

var stat_map: Dictionary = {
	Building.BuildingType.Attack : ant_damage,
	Building.BuildingType.Defense : ant_defense,
	Building.BuildingType.Speed : ant_speed,
	Building.BuildingType.Efficiency : efficiency,
	Building.BuildingType.Resources : resource_production,
	Building.BuildingType.Population : ant_production,	
}

func update_stat(b_type: Building.BuildingType, value: float):
	#print("stat upgrading value: ", Building.BuildingType.find_key(b_type), ": ", value )
	match b_type:
		Building.BuildingType.Attack:
			ant_damage += value;
		Building.BuildingType.Defense:
			ant_defense += value;
		Building.BuildingType.Speed:
			ant_speed += value;
		Building.BuildingType.Efficiency :
			efficiency += value;
		Building.BuildingType.Resources : 
			resource_production += value;
		Building.BuildingType.Population : 
			ant_production += value;	
	update_statmap();


func update_statmap():
	stat_map = {
	Building.BuildingType.Attack : ant_damage,
	Building.BuildingType.Defense : ant_defense,
	Building.BuildingType.Speed : ant_speed,
	Building.BuildingType.Efficiency : efficiency,
	Building.BuildingType.Resources : resource_production,
	Building.BuildingType.Population : ant_production,	
	}

func increment_buildings_placed():
	Global.resources -= Global.place_building_cost
	building_placed += 1
	calculate_place_building_cost()


func increment_buildings_skipped():
	Global.resources -= Global.skip_building_cost
	buildings_skipped += 1
	calculate_skip_building_cost()


func increment_deleted_clusters():
	Global.resources -= Global.delete_cluster_cost
	clusters_deleted += 1
	calculate_delete_clusters_cost()


func calculate_place_building_cost():
	place_building_cost = clamp(floor(building_placed * 0.4 /(((log(Global.efficiency)+1)/ log(2))*2)), 1, INF)


func calculate_skip_building_cost():
	skip_building_cost = clamp(floor(buildings_skipped * 0.275/(((log(Global.efficiency)+1)/ log(2))*2)), 0, INF)


func calculate_delete_clusters_cost():
	delete_cluster_cost = clamp(floor(clusters_deleted * 0.4), 1, INF)
