#hack for issues with hidden menu collision
extends Node3D
var original_position : Vector3


func _ready() -> void:
	original_position = position
	visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()


func _on_visibility_changed() -> void:
	if(visible):
		position = original_position
	else:
		position = Vector3(10000,10000,10000)
