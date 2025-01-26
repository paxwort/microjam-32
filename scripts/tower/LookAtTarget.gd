extends Node3D

@export var tracker : EnemyTracker

func _physics_process(delta: float) -> void:
	if (tracker != null) and (tracker.targeted != null):
		var target_position = tracker.targeted.global_position
		var diff = global_position - target_position
		rotation.y = lerp(rotation.y, atan2(diff.x, diff.z), delta * 10)
