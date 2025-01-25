class_name MazeMesher extends GridMap

@onready var maze : Maze = get_parent()
	
func _on_maze_created():
	clear()
	set_cells_from_maze(0, maze.size_x - 1, 0, maze.size_y - 1)

func set_cells_from_maze(min_x : int, max_x : int, min_y : int, max_y : int):
	for x in range(min_x,max_x):
		for y in range(min_y,max_y):
			var square_of_cells : int = 0
			square_of_cells |= (0b1 if maze.get_cell(x,y) == 1 else 0)
			square_of_cells |= (0b10 if maze.get_cell(x,y+1) == 1 else 0)
			square_of_cells |= (0b100 if maze.get_cell(x+1,y) == 1 else 0)
			square_of_cells |= (0b1000 if maze.get_cell(x+1,y+1) == 1 else 0)
			set_cell_item(Vector3i(x,0,y), square_of_cells)
