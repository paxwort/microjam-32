extends Label3D

func _process(delta: float) -> void:
	text = str(GameManager.Score)
