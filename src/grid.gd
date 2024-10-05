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
			cell.row = r
			cell.column = c
			column.append(cell)
		self.contents.append(column)


func update(delta: float) -> void:
	queue_redraw()
	var mouse_pos = get_local_mouse_position()
	mouse_grid_pos = Vector2i(mouse_pos.x / 4, mouse_pos.y / 4)
	
	for row in contents:
		for cell in row:
			cell.color = Color.BLACK
	
	#if mouse_grid_pos.x >= 0 and mouse_grid_pos.x < columns and \
		#mouse_grid_pos.y >= 0 and mouse_grid_pos.y < rows:
		#contents[mouse_grid_pos.x][mouse_grid_pos.y].color = Color.WHITE


func get_neighbour(cell: Cell, direction: Direction) -> Cell:
	match direction:
		Direction.North:
			return contents[cell.row-1][cell.column]
		Direction.East:
			return contents[cell.row][cell.column+1]
		Direction.South:
			return contents[cell.row+1][cell.column]
		Direction.West:
			return contents[cell.row][cell.column-1]
	
	return null


func _draw() -> void:
	if contents.size() > 0:
		for row in range(contents[0].size()):
			for column in range(contents.size()):
				draw_rect(Rect2i(row*4, column*4, 3, 3), contents[row][column].color)
