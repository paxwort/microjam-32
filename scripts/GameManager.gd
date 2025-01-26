class_name game_manager
extends Node

const MAX_HEALTH = 25
var Health: int
var GameInProgress = false
var Score: int
var CurrentWave: int

var Wallet: int

signal reset_game_state
signal start_next_wave(WaveNumber)
signal game_over

func _init() -> void:
	_start_new_game()

func _start_new_game() -> void:
	GameInProgress = true
	CurrentWave = 0
	Score = 0
	Wallet = 100
	Health = MAX_HEALTH
	reset_game_state.emit()

func _end_game() -> void:
	print("Game Over")
	GameInProgress = false
	game_over.emit()
	_start_new_game()
	
func trigger_next_wave() -> void:
	CurrentWave += 1
	print("Triggering wave %s" % CurrentWave)
	if (CurrentWave == 7):
		_end_game()
	else:
		start_next_wave.emit(CurrentWave)
	

func add_score(score: int = 1) -> void:
	Score += score
	Wallet += (score * 5)
	print("Score: %s" % Score)

func spend_from_wallet(amount: int) -> void:
	if amount >  Wallet:
		pass
	Wallet -= amount

func on_enemy_reached_end_of_run() -> void:
	if GameInProgress:
		Health -= 1
		print("Health: %s" % Health)
	if(Health <= 0 && GameInProgress):
		_end_game()
