class_name EnemyController
extends CharacterBody3D

@export var Movement: MovementComponent
@export var Health: HealthComponent

signal enemy_died

func _ready() -> void:
	enemy_died.connect(GameManager.add_score)
	if(Health):
		Health.enemy_out_of_health.connect(_kill_self)

func _kill_self(body: Node3D) -> void:
	enemy_died.emit()
	var parent = get_parent()
	if parent is PathFollowMovement:
		parent.queue_free()


func _on_damage_collision_area_body_entered(body: Node3D) -> void:
	print("Ouch!")
	if(body.get_parent() is DamageObject and body.get_parent().is_active):
		Health.take_damage(1)
		body.get_parent().explode()
