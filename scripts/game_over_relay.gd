extends Node

signal game_over

func _ready() -> void:
	GameManager.game_over.connect(_gameover)

func _gameover() -> void:
	game_over.emit()
