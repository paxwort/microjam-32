class_name TowerPlacementCursor extends Node3D

@export var tower_data : TowerData
var is_placing = false
signal tower_placed
signal placing_started

func start_placing():
	placing_started.emit()
	is_placing = true

func stop_placing():
	is_placing = false
	tower_placed.emit()

func _physics_process(delta: float) -> void:
	if !is_placing:
		return
	var raycast : Dictionary = raycast_to_tower_placement_plane()
	if(raycast.keys().size() > 0):
		if raycast.collider is TowerPlacementPlane:
			var drop_position = raycast.collider.get_drop_position(raycast.position)
			global_position = drop_position
			if check_placement_valid(drop_position):
				print("valid")
				$Indicators/Indicator_Valid.show()
				$Indicators/Indicator_Invalid.hide()
				input_place_tower()
			else:
				print("invalid")
				$Indicators/Indicator_Invalid.show()
				$Indicators/Indicator_Valid.hide()

func input_place_tower():
	if Input.is_action_just_pressed("place_tower"):
			var tower = tower_data.tower_prefab.instantiate()
			%Map.add_child(tower)
			tower.global_position = global_position
			%Map.find_child("Maze").created.connect(tower.queue_free)
			stop_placing()

func check_placement_valid(drop_position) -> bool:
	var maze : Maze = %Map.find_child("Maze")
	var coord = maze.world_to_maze_coordinate(drop_position)
	var cell_type = maze.get_cell(coord.x, coord.y)
	if (tower_data.can_place_path
			and (cell_type == 1)):
		return true
	elif (tower_data.can_place_wall
			and (cell_type == 0)):
		return true
	elif (tower_data.can_place_neighbouring_path
			and (cell_type == 0)
			and (maze.get_cell_neighbours(coord.x, coord.y).has(1))):
		return true
	return false

func raycast_to_tower_placement_plane() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = 1 << 8 #mask to only hit tower placement plane
	query.collide_with_areas = true

	return space_state.intersect_ray(query)
