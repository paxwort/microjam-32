class_name MazeMesher extends Node

var grid : Array[Array]
var gridmap : GridMap

func _ready() -> void:
	grid = [[0,1,0,1],[1,1,1,1],[0,0,1,1],[1,0,0,0]]

func grid_cells_to_gridmap(size_x : int, size_y : int):
	for x in range(0,size_x):
		for y in range(0,size_y):
			var square_of_cells : int = 0
			for i in range(0, 4):
				square_of_cells |= 0b1 if grid[x][y] == 1 else 0
				square_of_cells |= 0b10 if grid[x][y+1] == 1 else 0
				square_of_cells |= 0b100 if grid[x+1][y] == 1 else 0
				square_of_cells |= 0b1000 if grid[x][y+1] == 1 else 0
			gridmap.set_cell_item(Vector3i(x,0,y), square_of_cells)
