class_name Grid extends Node2D


enum Direction {North, South, East, West}

@export var rows: int;
@export var columns: int;

var contents: Array[Array] = [];



var mouse_grid_pos: Vector2i = Vector2i(0,0)


func _ready() -> void:
	for r in range(rows):
		var column = []
		for c in range(columns):
			var cell = Cell.new()
			cell.grid = self;
			cell.row = r
			cell.column = c
			column.append(cell)
		self.contents.append(column)
	
	contents[0][2].type = Building.BuildingType.Default


func update(delta: float) -> void:
	queue_redraw()
	var mouse_pos = get_local_mouse_position()
	mouse_grid_pos = Vector2i(mouse_pos.x / 4, mouse_pos.y / 4)
	
	for row in contents:
		for cell in row:
			cell.highlighted = false
			cell.show_deny_placing = false
	
	#if mouse_grid_pos.x >= 0 and mouse_grid_pos.x < columns and \
		#mouse_grid_pos.y >= 0 and mouse_grid_pos.y < rows:
		#contents[mouse_grid_pos.y][mouse_grid_pos.x].highlight(Building.BuildingType.Attack)


func get_neighbour(cell: Cell, direction: Direction) -> Cell:
	var row = cell.row
	var column = cell.column
	
	match direction:
		Direction.North:
			if row <= 0: return null
			return contents[row-1][column]
		Direction.East:
			if column >= columns-1: return null
			return contents[row][column+1]
		Direction.South:
			if row >= rows-1: return null
			return contents[row+1][column]
		Direction.West:
			if column <= 0: return null
			return contents[row][column-1]
	
	return null


func _draw() -> void:
	for row in range(contents.size()):
		for col in range(contents[0].size()):
			var cell = contents[row][col]
			
			draw_rect(
				Rect2i(
					col*(Global.cell_size+1),
					row*(Global.cell_size+1),
					Global.cell_size,
					Global.cell_size
				),
				cell.get_draw_color()
			)
			
			if cell.show_deny_placing:
				draw_texture(preload("res://sprites/x.png"), Vector2i(
					col*(Global.cell_size+1)-1, row*(Global.cell_size+1)-1
					))
