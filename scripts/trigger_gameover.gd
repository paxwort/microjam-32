extends Node


# Called when the node enters the scene tree for the first time.
func trigger_gameover() -> void:
	GameManager._end_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
