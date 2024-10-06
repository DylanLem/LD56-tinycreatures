class_name Grid extends Node2D


enum Direction {North, South, East, West}

@export var rows: int;
@export var columns: int;

var contents: Array[Array] = [];

var root_cell: Cell



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
	
	root_cell = contents[0][0]
	root_cell.type = Building.BuildingType.Default


func update(delta: float) -> void:
	queue_redraw()
	var mouse_pos = get_local_mouse_position()
	mouse_grid_pos = Vector2i(mouse_pos.x / 4, mouse_pos.y / 4)
	
	for row in contents:
		for cell in row:
			cell.highlighted = false
			cell.show_x = false
			cell.show_darken = false
	
	#if mouse_grid_pos.x >= 0 and mouse_grid_pos.x < columns and \
		#mouse_grid_pos.y >= 0 and mouse_grid_pos.y < rows:
		#contents[mouse_grid_pos.y][mouse_grid_pos.x].highlight(Building.BuildingType.Attack)


func get_neighbour(cell: Cell, direction: Direction) -> Cell:

	match direction:
		Direction.North:
			if(cell.row>0):
				return contents[cell.row-1][cell.column]
		Direction.East:
			if(contents[cell.row].size() -1 > cell.column):
				return contents[cell.row][cell.column+1]
		Direction.South:
			if(contents.size() -1> cell.row):
				return contents[cell.row+1][cell.column]
		Direction.West:
			if(cell.column>0):
				return contents[cell.row][cell.column-1]

	
	return null


func _draw() -> void:
	for row in range(contents.size()):
		for col in range(contents[0].size()):
			var cell: Cell = contents[row][col]
			
			var darker = Color.from_hsv(0,0,0,0.2)
			draw_rect(
				Rect2i(
					col*(Global.cell_size+1)+1,
					row*(Global.cell_size+1)+1,
					1,
					1
				),
				darker
			)
			
			var rect = Rect2i(
				col*(Global.cell_size+1),
				row*(Global.cell_size+1),
				Global.cell_size,
				Global.cell_size
			)
			
			draw_rect(rect, cell.get_draw_color())
			
			if cell.disabled or cell.show_darken:
				var overlay = Color.from_hsv(0, 0, 0, 0.65)
				draw_rect(rect, overlay)
			
			if cell.show_x:
				draw_texture(preload("res://sprites/x.png"), Vector2i(
					col*(Global.cell_size+1)-1, row*(Global.cell_size+1)-1
					))


func validate_clusters() -> void:
	var traversed_clusters: Dictionary = {}
	
	for row in contents:
		for grid_cell: Cell in row:
			
			if grid_cell == null:
				continue
			
			var cluster: Cluster = grid_cell.cluster
			
			if cluster == null or traversed_clusters.has(cluster):
				continue
			
			traversed_clusters[cluster] = true
			
			if dijkstra(grid_cell, root_cell).dijk_prev == null:
				cluster.disable()
			else:
				cluster.enable()


func dijkstra(source: Cell, target: Cell) -> Cell:
	var unvisited: Array[Cell] = []

	for row in contents:
		for cell: Cell in row:
			cell.dijk_dist = INF
			cell.dijk_prev = null
			cell.dijk_visited = false
			
			if cell.type != Building.BuildingType.None:
				unvisited.append(cell)
		
	source.dijk_dist = 0
	
	var result: Cell = null
	
	var u: Cell = null
	
	while (unvisited.size() > 0):
		var nearest = INF
		var nearest_cell = null
		for i in unvisited:
			if i.dijk_dist <= nearest:
				nearest = i.dijk_dist
				nearest_cell = i
		u = nearest_cell
		
		if u == target:
			return u
		
		unvisited.erase(u)
		
		var neighbours: Array[Cell] = u.get_neighbours().filter(
			func(element):
				return not element.dijk_visited
		)
		
		#var valid_neighbours = []
		#for i in neighbours:
			#if unvisited.has(i):
				#valid_neighbours.append(i)
			#pass
		#print(valid_neighbours)
		
		for neighbour in neighbours:
			var alt = u.dijk_dist + 1;
			#if v.row != u.row and v.column != u.column:
				#alt += 0.4142;
			
			if alt < neighbour.dijk_dist:
				neighbour.dijk_dist = alt;
				neighbour.dijk_prev = u;
			
	return result
