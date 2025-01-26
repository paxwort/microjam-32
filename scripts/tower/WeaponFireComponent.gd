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

func fire_weapon() -> void:
	if(cooldown <= 0):
		print("firing weapon...")
		var new_projectile = projectile.instantiate()
		cooldown = 1.0/fire_rate
		get_tree().root.add_child(new_projectile)
		new_projectile.global_transform.origin = projectile_spawn_point.global_transform.origin
