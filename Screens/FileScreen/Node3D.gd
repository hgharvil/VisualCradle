extends Node3D


func _ready() -> void:
	
	var new_rotation = Vector3(0.0,deg_to_rad(90),0.0)
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation", new_rotation, 400).as_relative()
