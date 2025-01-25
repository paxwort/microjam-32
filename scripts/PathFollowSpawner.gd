class_name EnemySpawner
extends Node3D

@export var PrefabList: Array[PackedScene]
var PathFollower

var _path: Path3D

func _init() -> void:
	PathFollower = preload("res://prefabs/enemy_path_follower.tscn")

func _ready() -> void:
	_path = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_SPACE) and just_pressed:
		Spawn()

func Spawn() -> void:
	var toSpawn = PrefabList.pick_random()
	var enemy = toSpawn.instantiate()
	
	var pathFollow = PathFollower.instantiate().WithMovement(enemy.get_node("MovementNode"))
	
	pathFollow.add_child(enemy)
	_path.add_child(pathFollow)
