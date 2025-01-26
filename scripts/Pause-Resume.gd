extends SB_SimpleTransition
@export var resume : bool


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_resume()

func pause_resume():
	get_tree().paused = !resume
	go_to_state()
