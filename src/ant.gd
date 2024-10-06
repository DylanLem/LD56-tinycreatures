class_name Ant extends Node

var pos: int;
var sub_pos: float;

var hp: float;
var damage: float;


func _init(ant: bool):
	if(ant):
		self.hp = Global.ant_defense*(log(Global.efficiency)+1)
		self.damage = Global.ant_damage*(log(Global.efficiency)+1)
	else:
		self.hp = Global.termite_defense * (1 + (float(Global.current_level) * 0.25))
		self.damage = Global.termite_damage* (1 + (float(Global.current_level) * 0.25))
		
	pass
