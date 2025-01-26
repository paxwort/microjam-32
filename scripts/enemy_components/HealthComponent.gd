class_name HealthComponent
extends Node

@export var MAX_HEALTH = 5

signal enemy_out_of_health(enemy)

var CurrentHealth = 0

func _ready() -> void:
	CurrentHealth = MAX_HEALTH
	
func take_damage(damage: int) -> void:
	CurrentHealth -= damage
	print("Current health: %s" % CurrentHealth)
	if(CurrentHealth <= 0):
		enemy_out_of_health.emit(get_parent())
