class_name MazeMesher extends GridMap

@export var maze : Maze
	
func _on_maze_created():
	clear()
	set_cells_from_maze(maze.size_x, maze.size_y)

func set_cells_from_maze(size_x : int, size_y : int):
	for x in range(0,size_x):
		for y in range(0,size_y):
			var square_of_cells : int = 0
			square_of_cells |= (0b1 if maze.cells[x][y] == 1 else 0)
			if y < size_y - 1:
				square_of_cells |= (0b10 if maze.cells[x][y+1] == 1 else 0)
			if x < size_x - 1:
				square_of_cells |= (0b100 if maze.cells[x+1][y] == 1 else 0)
			if x < size_x - 1 and y < size_y - 1:
				square_of_cells |= (0b1000 if maze.cells[x+1][y+1] == 1 else 0)
			set_cell_item(Vector3i(x,0,y), square_of_cells)
