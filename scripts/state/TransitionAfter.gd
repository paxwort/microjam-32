extends SB_SimpleTransition

@export var time : float
var timer : SceneTreeTimer

func _on_state_enabling(prev_state : String = "") -> void:
	cooldown_start()

func _on_state_disabling() -> void:
	cooldown_abort()

func cooldown_start() -> void:
	timer = get_tree().create_timer(time)
	timer.timeout.connect(go_to_state)

func cooldown_abort() -> void:
	if timer != null:
		timer.timeout.disconnect(go_to_state)
		timer = null
