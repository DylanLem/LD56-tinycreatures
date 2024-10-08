class_name Main extends Node2D


var mouse_pos: Vector2;
var grid: Grid;
var current_building: Building = null
var next_building: Building = null
var delete_mode: bool = false

var sfx = {
	"placement":preload("res://sfx/plop.wav"),
	"skip":preload("res://sfx/Skip.wav"),
	"delete":preload("res://sfx/delete.wav"),
	"invalid":preload("res://sfx/No no.wav")
}

var music = {
	"Termite Extermination": preload("res://sfx/Termite Extermination.wav"),
	"HATEFUL CREATURES": preload("res://sfx/HATEFULCREATURESV2.wav"),
	"In the Maw of Hell": preload("res://sfx/Ants will win.wav"),
	"Dream of Peace" : preload("res://sfx/Dream of Peace.wav")
}
var song_strings: Array[String] = ["Termite Extermination", "HATEFUL CREATURES", "In the Maw of Hell", "Dream of Peace"]

var current_song: String = "Termite Extermination";

var backgrounds: Array = [preload("res://sprites/sky.png"), preload("res://sprites/night_sky.png")]

func _ready() -> void:
	
	$Sky.texture = backgrounds.pick_random();
	if($Sky.texture == backgrounds[1]):
		$Sky.night_time = true;
		
	$Sky.initialize_clouds()
	Global.initialize_values();
	grid = get_node("Grid");
	
	
	current_building = get_random_building()
	next_building = get_random_building()
	
	$PurchaseDisplay/ModeButton.pressed.connect(toggle_delete_mode)
	$CurrentSong.text = current_song;
	pass # Replace with function body.


func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("right_click"):
		#get_tree().change_scene_to_file("res://scenes/level_transition.tscn");
	
	if ($TermiteHole.termites.size() > 0 and \
	$TermiteHole.termites.front().pos - $Anthill.position.x < 16):
		if(!$WarningSound.playing):
			$WarningSound.play();
		$WarningSprite.play()
		$WarningSprite.visible = true
	else:
		$WarningSound.stop();
		$WarningSprite.stop()
		$WarningSprite.visible = false
	
	grid.update(delta)
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	var mouse_pos = grid.mouse_grid_pos
	
	if mouse_pos.x >= 0 and \
	mouse_pos.x < grid.columns and \
	mouse_pos.y >= 0 and \
	mouse_pos.y < grid.rows:
		if not delete_mode:
			if Input.is_action_just_pressed("right_click"):
				current_building.rotate_clockwise()
			
			var building_cells = []
			
			var valid_position = true
			
			for r in range(current_building.get_n_rows()):
				for c in range(current_building.get_n_cols()):
					var building_row = clamp(mouse_pos.y - floor(current_building.get_n_rows() / 2.0), 0, (grid.rows-1) - current_building.get_n_rows() + 1) + r
					var building_col = clamp(mouse_pos.x - floor(current_building.get_n_cols() / 2.0), 0, (grid.columns-1) - current_building.get_n_cols() + 1) + c
					
					var cell = grid.contents[building_row][building_col]
					
					var building_cell_type = current_building.shape[r][c]
					
					if (cell.type != Building.BuildingType.None and \
					building_cell_type != Building.BuildingType.None):
						#cell.show_x = true
						cell.highlight(building_cell_type)
						cell.show_darken = true
						valid_position = false
					elif building_cell_type != Building.BuildingType.None:
						cell.highlight(building_cell_type)
						building_cells.append(cell)
			
			var has_neighbour = false
			for cell in building_cells:
				if has_neighbour: break
				for neighbour in cell.get_neighbours():
					if neighbour.type != Building.BuildingType.None and \
					not neighbour.disabled:
						has_neighbour = true
						break
			
			if not has_neighbour:
				for cell in building_cells:
					cell.show_darken = true
					pass
			
			if (not has_neighbour or not valid_position) and Input.is_action_just_pressed("left_click"):
				$SoundEffects.stream = sfx["invalid"]
				$SoundEffects.play()
				
			if valid_position and has_neighbour:
				if Input.is_action_just_pressed("left_click"):
					if Global.resources >= Global.place_building_cost:
						place_building(building_cells)
						advance_building()
						grid.validate_clusters()
						$SoundEffects.stream = sfx["placement"]
						$SoundEffects.play()
					else:
						$SoundEffects.stream = sfx["invalid"]
						$SoundEffects.play()
						$PurchaseDisplay/PlaceIcon/Label/ShakeTimer.start() 
						pass
					
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		else:
			var hovered_cell: Cell = grid.contents[mouse_pos.y][mouse_pos.x]
			
			var hovered_cluster: Cluster = hovered_cell.cluster
			
			if hovered_cluster != null:
				for cell: Cell in hovered_cluster.cells:
					#cell.highlight(Building.BuildingType.Invalid)
					cell.show_x = true
				
				if Input.is_action_just_pressed("left_click"):
					if Global.resources >= Global.delete_cluster_cost:
						$SoundEffects.stream = sfx["delete"]
						$SoundEffects.play()
						hovered_cluster.delete()
						grid.validate_clusters()
						Global.increment_deleted_clusters()
					else:
						$SoundEffects.stream = sfx["invalid"]
						$SoundEffects.play()
						$PurchaseDisplay/ModeButton/Label/ShakeTimer.start()
			
			pass
	
	
	$ResourcesLabel.text = "  x" + str(int(Global.resources))


func place_building(cells) -> void:
	for cell in cells:
		cell.type = cell.highlight_type
		if(cell.type != Building.BuildingType.None):
			var icon = IconEffect.new()
			icon.type = cell.type;
			add_child(icon)
			cell.on_board_placement()
	Global.increment_buildings_placed()


func advance_building() -> void:
	current_building = next_building
	next_building = get_random_building()


func get_random_building() -> Building:
	return Building.new()


func _on_resource_production_timer_timeout() -> void:
	Global.resources += Global.resource_production


func toggle_delete_mode() -> void:
	delete_mode = not delete_mode


func _on_skip_button_pressed() -> void:
	var song_index = song_strings.find(current_song)
	var next = song_strings[song_index +1] if song_index < song_strings.size()-1 else song_strings[0]
	print(next)
	current_song = next;
	$CurrentSong.text = current_song;
	$MusicPlayer.stream = music[next]
	$MusicPlayer.play();
	pass # Replace with function body.


func _on_sound_on_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		$MusicPlayer.volume_db = -100.;
	else:
		$MusicPlayer.volume_db = -11;
	pass # Replace with function body.
