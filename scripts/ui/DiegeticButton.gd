extends Node3D

signal pressed
var mesh_instance

func _ready():
	var mesh_children = find_children("*", "MeshInstance3D")
	if(mesh_children.size() > 0):
		mesh_instance = mesh_children.front()

func _physics_process(delta: float) -> void:
	var raycast : Dictionary = raycast_to_diegetic_ui()
	if(raycast.keys().size() > 0):
		if get_children().has(raycast.collider):
			mesh_instance.rotation.x = .1
			if Input.is_action_just_pressed("ui_interact"):
				pressed.emit()
		else:
			mesh_instance.rotation.x = 0
	else:
		mesh_instance.rotation.x = 0


func raycast_to_diegetic_ui() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = 1 << 9 #mask to only hit tower placement plane
	query.collide_with_areas = true

	return space_state.intersect_ray(query)
