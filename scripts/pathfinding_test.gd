extends Node3D


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		GameManager.trigger_next_wave()
