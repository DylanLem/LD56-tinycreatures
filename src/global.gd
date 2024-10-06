extends Node


const cell_size: int = 3

var resources: float = 1

var resource_production: float = 0.5;

var ant_damage: float = 1.0;
var ant_defense: float = 1.0;
var termite_damage: float = 1.0;
var termite_defense: float = 1.0;


var efficiency: float = 1.0;


var ant_production: float = 1.0;
var termite_production: float = 1.0;

var ant_speed: float = 2.0;
var termite_speed: float = -2.0;

var building_placed: int = 0
var buildings_skipped: int = 0

var place_building_cost: int = 1
var skip_building_cost: int = 1

var colour_links: Array[Vector2];
var colour_link_colours: Array[Color];


var stat_map: Dictionary = {
	Building.BuildingType.Attack : ant_damage,
	Building.BuildingType.Defense : ant_defense,
	Building.BuildingType.Speed : ant_speed,
	Building.BuildingType.Efficiency : efficiency,
	Building.BuildingType.Resources : resource_production,
	Building.BuildingType.Population : ant_production,	
}

func update_stat(b_type: Building.BuildingType, value: float):
	print("stat upgrading value: ", Building.BuildingType.find_key(b_type), ": ", value )
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
	Global.resources -= place_building_cost
	
	building_placed += 1
	place_building_cost = clamp(floor(building_placed * 0.4), 1, INF)


func increment_buildings_skipped():
	Global.resources -= Global.skip_building_cost
	
	buildings_skipped += 1
	skip_building_cost = clamp(floor(buildings_skipped * 0.275), 1, INF)
