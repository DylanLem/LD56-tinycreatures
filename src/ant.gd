class_name Ant extends Node

var pos: int;
var sub_pos: float;

var hp: float;
var damage: float;


func _init(ant: bool):
	if(ant):
		self.hp = Global.ant_defense
		self.damage = Global.ant_damage
	else:
		self.hp = Global.termite_defense
		self.damage = Global.termite_damage
		
	pass
