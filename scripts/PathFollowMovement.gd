class_name PathFollowMovement
extends PathFollow3D

var _movement: MovementComponent

func _init() -> void:
	loop = false
	
func WithMovement(movement: MovementComponent) -> PathFollowMovement:
	_movement = movement
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += _movement.speed * delta
	if progress_ratio >= 1:
		queue_free()
	
