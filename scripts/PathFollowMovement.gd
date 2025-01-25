class_name PathFollowMovement
extends PathFollow3D

var _movement: MovementComponent

signal enemy_reached_end_of_run()

func _init() -> void:
	loop = false
	enemy_reached_end_of_run.connect(GameManager.on_enemy_reached_end_of_run)

func WithMovement(movement: MovementComponent) -> PathFollowMovement:
	_movement = movement
	return self

func _process(delta: float) -> void:
	progress += _movement.speed * delta
	if progress_ratio >= 1:
		_end_of_run()

func _end_of_run():
	enemy_reached_end_of_run.emit()
	queue_free()
