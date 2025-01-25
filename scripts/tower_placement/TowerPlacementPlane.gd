class_name TowerPlacementPlane extends Node
@onready var maze : Maze = get_parent()

func get_drop_position(world_position : Vector3) -> Vector3:
	var maze_coord = maze.world_to_maze_coordinate(world_position)
	return maze.maze_to_world_coordinate(maze_coord)
