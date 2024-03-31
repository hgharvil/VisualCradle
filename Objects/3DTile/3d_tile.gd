extends StaticBody3D

@onready var label_3d: Label3D = $Label3D
@onready var cube_mesh: MeshInstance3D = $CubeMesh
@onready var square: MeshInstance3D = $Square


var is_visited := false:
	set(new_state):
		is_visited = new_state
		if is_visited:
			var material = StandardMaterial3D.new()
			material.albedo_color = Color.WHITE
			cube_mesh.set_surface_override_material(0,material)
			#square.set_surface_override_material(0,material)
			visible = true
var destination := Vector3.ZERO
var label := "N0":
	set(new_label):
		label = new_label
		label_3d.text = label
		if label == "00" or label == "N0" or label == "N1" or label == "N6":
			#print("off: label: ", label)
			label_3d.visible = false
			if label != "N1":
				visible = false
			if label == "N6":
				var material = StandardMaterial3D.new()
				material.albedo_color = Color.BLUE
				square.set_surface_override_material(0,material)
		else:
			#print("on: label: ", label)
			label_3d.visible = true
var text := "No data"
var label_rotation : Vector3:
	set(new_rotation):
		label_rotation = new_rotation
		label_3d.rotation = label_rotation
