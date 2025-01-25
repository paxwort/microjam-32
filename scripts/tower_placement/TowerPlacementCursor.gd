extends Node3D

@export var tower_prefab : PackedScene
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
		if Input.is_action_just_pressed("place_tower"):
			var tower = tower_prefab.instantiate()
			%Map.add_child(tower)
			tower.global_position = global_position
			stop_placing()

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
