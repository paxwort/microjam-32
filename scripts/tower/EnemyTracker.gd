class_name EnemyTracker extends Area3D

var tracked : Array[Node3D] = []
var targeted : Node3D

signal targeted_changed

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	if targeted:
		$"../WeaponFireComponent".fire_weapon(targeted.global_transform)
	
func _on_body_entered(body : Node3D) -> void:
	var trackables = body.find_children("*", "TrackableComponent")
	if trackables.size() > 0:
		tracked.push_back(body)
	target_new()

func _on_body_exited(body : Node3D) -> void:
	if tracked.has(body):
		tracked.erase(body)
	target_new()

func target_new():
	targeted = null
	if tracked.size() > 0:
		targeted = tracked.front()
	targeted_changed.emit()
