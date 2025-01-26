class_name Projectile
extends Node3D

var _speed:float = 1

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
		direction = direction.rotated(Vector3.UP, rotation.y)
		position += direction * _speed * delta

func set_speed(speed: float) -> void:
	_speed=speed

func _on_destruction_timer_timeout() -> void:
	queue_free()
	
func explode():
	is_active = false
	queue_free()
