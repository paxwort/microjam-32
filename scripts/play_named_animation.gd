extends Node
@export var player : AnimationPlayer
@export var animation_name : String
@export var reverse : bool

func play():
	if not reverse:
		player.play(animation_name)
	else:
		player.play_backwards(animation_name)
