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

func fire_weapon(target_pos: Vector3) -> void:
	if(cooldown <= 0):
		cooldown = 1.0/fire_rate
		
		var new_projectile = projectile.instantiate()
		new_projectile.global_position = projectile_spawn_point.global_position
		new_projectile.look_at(target_pos, Vector3(0,1,0))
		new_projectile.rotation.x = deg_to_rad(90)
		new_projectile.scale = Vector3(0.05,0.05,0.05)
		
		
		
		get_tree().root.add_child(new_projectile)
		
