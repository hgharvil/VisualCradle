extends DirectionalLight3D

func _ready() -> void:
	
	var light_rotation = Vector3(0.0,deg_to_rad(30),0.0)
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation", light_rotation, 4).as_relative()
