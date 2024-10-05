extends Node


const cell_size: int = 3

var resources: float = 1

var resource_production: float = 0.5;
var ant_production: float = 10.0;
var termite_production: float = 1.0;

var ant_speed: float = 40.0;
var termite_speed: float = 1.0;

var building_placed: int = 0
var buildings_skipped: int = 0

var place_building_cost: int = 1
var skip_building_cost: int = 1

var colour_links: Array[Vector2];
var colour_link_colours: Array[Color];


func increment_buildings_placed():
	Global.resources -= place_building_cost
	
	building_placed += 1
	place_building_cost = clamp(floor(building_placed * 0.4), 1, INF)


func increment_buildings_skipped():
	Global.resources -= Global.skip_building_cost
	
	buildings_skipped += 1
	skip_building_cost = clamp(floor(buildings_skipped * 0.275), 1, INF)
