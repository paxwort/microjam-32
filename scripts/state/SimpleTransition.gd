class_name SB_SimpleTransition extends PLStateBehaviour

@export var target_state : String
@export var wait_for_frame : bool

func go_to_state() -> void:
	if target_state != null and state.machine.active_state_key == state.name:
		if wait_for_frame: 
			await get_tree().physics_frame
		state.machine.transition_to(target_state)
