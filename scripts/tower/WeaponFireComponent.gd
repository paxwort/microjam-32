class_name WeaponFireComponent
extends Node

@export var projectile: PackedScene
@export var fire_rate: float
@export var projectile_speed: float
@export var projectile_spawn_point: Node3D

var cooldown: float

func _ready() -> void:
	cooldown = 0
	

func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown-=delta

func fire_weapon(target_pos: Transform3D) -> void:
	if(cooldown <= 0):
		cooldown = 1.0/fire_rate
		
		var new_projectile = projectile.instantiate()
		get_tree().root.add_child(new_projectile)
		new_projectile.global_position = projectile_spawn_point.global_position
		new_projectile.scale = Vector3(0.02,0.02,0.02)
		
		new_projectile.look_at(target_pos.origin, Vector3.UP)
		new_projectile.rotation.z = deg_to_rad(90)
		new_projectile.set_speed(projectile_speed)
		
