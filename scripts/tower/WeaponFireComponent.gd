class_name WeaponFireComponent
extends Node

@export var Damage_Object_Prefab: PackedScene
@export var fire_rate: float
@export var projectile_speed: float
@export var projectile_spawn_point: Node3D

var cooldown: float

signal weapon_fire

func _ready() -> void:
	cooldown = 0
	

func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown-=delta

func fire_weapon(target_pos: Transform3D) -> void:
	if(cooldown <= 0):
		cooldown = 1.0/fire_rate
		var damageObject = Damage_Object_Prefab.instantiate()
		get_tree().root.add_child(damageObject)
		damageObject.global_position = projectile_spawn_point.global_position
		damageObject.look_at(target_pos.origin, Vector3.UP)
		damageObject.rotation.z = deg_to_rad(90)
		damageObject.set_speed(projectile_speed)
		weapon_fire.emit()
