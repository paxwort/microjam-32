class_name game_manager
extends Node

const MAX_HEALTH = 10
var Health: int
var GameInProgress = false
var Score: int

signal reset_game_state

func _init() -> void:
	_start_new_game()

func _start_new_game() -> void:
	GameInProgress = true
	Score = 0
	Health = MAX_HEALTH
	reset_game_state.emit()

func _end_game() -> void:
	print("Game Over")
	GameInProgress = false

func on_enemy_reached_end_of_run() -> void:
	if GameInProgress:
		Health -= 1
		print("Health: %s" % Health)
	if(Health <= 0 && GameInProgress):
		_end_game()
