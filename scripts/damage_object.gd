class_name DamageObject
extends Node3D

@export var _speed:float = 1
@export var oneshot : bool = true
var destruction_timer: Timer
var is_active: bool = false
@onready var collision_shape: CollisionShape3D = $RigidBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	destruction_timer = Timer.new()
	destruction_timer.wait_time = 1
	destruction_timer.one_shot = true
	destruction_timer.connect("timeout", _on_destruction_timer_timeout)
	destruction_timer.autostart = true
	is_active = true
	add_child(destruction_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active:
		var direction = Vector3(0, 0, -1).normalized()
		direction = -transform.basis.z
		position += direction * _speed * delta

func set_speed(speed: float) -> void:
	_speed=speed

func _on_destruction_timer_timeout() -> void:
	if(oneshot):
		queue_free()
	
func explode():
	if(oneshot):
		is_active = false
		queue_free()
