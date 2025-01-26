class_name Maze extends Node3D

var cells : Array[Array]
var size_x : int = 20
var size_y : int = 20
signal created


func world_to_maze_coordinate(world_coordinate : Vector3) -> Vector2i:
	var local_coordinate = world_coordinate - global_position
	return Vector2i(local_coordinate.x, local_coordinate.z)

func maze_to_world_coordinate(maze_coordinate : Vector2i) -> Vector3:
	return global_position + Vector3(maze_coordinate.x, 1.5, maze_coordinate.y)

func create_new_maze():
	var max_iterations = 20
	var path : Array[Vector2i]= [] 
	while(max_iterations > 0):	
		flood_empty()
		var start = Vector2i(size_x / 2, 0)
		generate_maze(start)
		var new_path = find_nice_path(start)
		if(new_path.size() > path.size()):
			path = new_path
		max_iterations -= 1
	flood_empty()
	cut_path(path)
	set_game_path(path)
	created.emit()

func get_cell_neighbours(x, y) -> Array[int]:
	var neighbours = [
		get_cell(x - 1,y),
		get_cell(x + 1,y),
		get_cell(x,y - 1),
		get_cell(x,y + 1)
	]
	return neighbours

func get_cell(x, y) -> int:
	if x >= 0 and y >= 0 and x < size_x and y < size_y:
		return cells[x][y]
	return 0
	
func set_cell(x, y, val) -> void:
	if x >= 0 and y >= 0 and x < size_x and y < size_y:
		cells[x][y] = val

func set_game_path(path : Array[Vector2i]):
	var curve = Curve3D.new()
	for v in path:
		curve.add_point(Vector3(v.x, 0, v.y))
	$MazePath.curve = curve

func cut_path(path : Array[Vector2i]):
	for v in path:
		set_cell(v.x, v.y, 1)

func flood_empty() -> void:
	cells = []
	for x in range(0,size_x):
		cells.push_back([])
		for y in range(0, size_y):
			cells[x].push_back(0)

func generate_maze(start : Vector2i):
	var frontier : Array
	frontier.push_back([start.x, start.y, start.x, start.y])
	while frontier.size() > 0:
		var random_index = randi_range(0, frontier.size() - 1)
		var f = frontier.pop_at(random_index)
		var u = f[0]
		var v = f[1]
		var x = f[2]
		var y = f[3]
		if(cells[x][y] == 0):
			cells[u][v] = 1
			cells[x][y] = 1
			if (x >= 2) and (cells[x - 2][y] == 0):
				frontier.push_back([x - 1, y, x - 2, y])
			if (y >= 2) and (cells[x][y - 2] == 0):
				frontier.push_back([x, y - 1, x, y - 2])
			if (x < size_x - 2) and (cells[x + 2][y] == 0):
				frontier.push_back([x + 1, y, x + 2, y])
			if (y < size_y - 2) and (cells[x][y + 2] == 0):
				frontier.push_back([x, y + 1, x, y + 2])

class DijkstraNode:
	var position : Vector2i
	var distance : int
	var prev : DijkstraNode
	func _init(p_position : Vector2i, p_distance : int, p_prev : DijkstraNode = null):
		position = p_position
		distance = p_distance
		prev = p_prev

#Dijkstra the maze to find a nice path by some heuristic
func find_nice_path(start : Vector2i):
	var open_set = [DijkstraNode.new(start, 0)]
	var visited = {}
	var distances = {}
	var neighbour_offsets = [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,1),Vector2i(0,-1)]
	var best_node : DijkstraNode
	best_node = open_set[0]
	while open_set.size() > 0:
		open_set.sort_custom(func(a,b) : return a.distance < b.distance)
		var current = open_set.pop_front()
		if(visited.has(current.position)):
			continue
		visited[current.position] = true
		
		if(current.distance > best_node.distance):
			var threshhold = 4
			if(Vector2i(size_x / 2, size_y / 2) - current.position).length() < threshhold:
				best_node = current
		
		for offset in neighbour_offsets:
			var next_position = current.position + offset
			if get_cell(next_position.x, next_position.y) == 1:
				var new_distance = current.distance + 21
				if not distances.has(next_position) or new_distance < distances[next_position].distance:
					var next_node = DijkstraNode.new(next_position, new_distance, current)
					distances[next_position] = next_node
					open_set.push_back(next_node)
	
	var path : Array[Vector2i]= []
	while (best_node != null):
		path.push_front(best_node.position)
		best_node = best_node.prev
	return path
