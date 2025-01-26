extends Button


func _pressed() -> void:
	GameManager.trigger_next_wave()
