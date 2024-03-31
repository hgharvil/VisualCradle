extends Node3D
@onready var sphere: MeshInstance3D = $Sphere


func _ready() -> void:
	
	var sphere_rotation = Vector3(0.0,deg_to_rad(30),0.0)
	var tween = create_tween().set_loops()
	tween.tween_property(sphere, "rotation", sphere_rotation, 6).as_relative()
