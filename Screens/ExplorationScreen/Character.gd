extends Node3D

@onready var debug_character: StaticBody3D = $DebugCharacter
@onready var camera_pivot: Node3D = $"../CameraPivot"
@onready var map: Node3D = $"../Map"

var up_direction = 270
var down_direction = 90
var left_direction = 0
var right_direction = 180

var up_character = Vector3.RIGHT
var down_character = Vector3.LEFT
var left_character = Vector3.FORWARD
var right_character = Vector3.BACK

enum DIRECTION {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

func _ready() -> void:
	position = Global.player_coordinates
	camera_pivot.position = position + Vector3(0.5,0,0.5)
	map.mark_tile_visited(position)

func try_move(direction : DIRECTION):
	var new_pos
	if direction == DIRECTION.UP:
		if fmod(up_direction,90) != 0:
			debug_character.rotation_degrees.y = up_direction + 45
		else:
			debug_character.rotation_degrees.y = up_direction
		new_pos = position + up_character
	elif direction == DIRECTION.DOWN:
		if fmod(up_direction,90) != 0:
			debug_character.rotation_degrees.y = down_direction + 45
		else:
			debug_character.rotation_degrees.y = down_direction
		new_pos = position + down_character
	elif direction == DIRECTION.LEFT:
		if fmod(up_direction,90) != 0:
			debug_character.rotation_degrees.y = left_direction + 45
		else:
			debug_character.rotation_degrees.y = left_direction
		new_pos = position + left_character
	elif direction == DIRECTION.RIGHT:
		if fmod(up_direction,90) != 0:
			debug_character.rotation_degrees.y = right_direction + 45
		else:
			debug_character.rotation_degrees.y = right_direction
		new_pos = position + right_character
	if map.is_position(new_pos):
		position = new_pos
		map.mark_tile_visited(position)
		camera_pivot.position = position + Vector3(0.5,0,0.5)
		Global.player_coordinates = position
	

# at CameraPivot at -45 and -90: up = up_direction
# at CameraPivot at 45 and 0: up = left_direction
# at CameraPivot at 135 and 90: up = down_direction
# at CameraPivot at 225 and 180: up = right_direction
# direction -1 = left; 1 = right
func rotate_camera(is_right_direction):
	if is_right_direction:
		up_direction = fmod(up_direction + 45, 360)
		down_direction = fmod(down_direction + 45, 360)
		left_direction = fmod(left_direction + 45, 360)
		right_direction = fmod(right_direction + 45, 360)
		camera_pivot.rotation += Vector3(0,deg_to_rad(45),0)
	else:
		up_direction = fmod(up_direction + 315, 360)
		down_direction = fmod(down_direction + 315, 360)
		left_direction = fmod(left_direction + 315, 360)
		right_direction = fmod(right_direction + 315, 360)
		camera_pivot.rotation += Vector3(0,deg_to_rad(315),0)
	if up_direction == fmod(225,360) or up_direction == fmod(270,360):
		up_character = Vector3.RIGHT
		down_character = Vector3.LEFT
		left_character = Vector3.FORWARD
		right_character = Vector3.BACK
	elif up_direction == fmod(135,360) or up_direction == fmod(180,360):
		up_character = Vector3.BACK
		down_character = Vector3.FORWARD
		left_character = Vector3.RIGHT
		right_character = Vector3.LEFT
	elif up_direction == fmod(45,360) or up_direction == fmod(90,360):
		up_character = Vector3.LEFT
		down_character = Vector3.RIGHT
		left_character = Vector3.BACK
		right_character = Vector3.FORWARD
	elif up_direction == fmod(315,360) or up_direction == fmod(0,360):
		up_character = Vector3.FORWARD
		down_character = Vector3.BACK
		left_character = Vector3.LEFT
		right_character = Vector3.RIGHT
	#print("up_direction: ", up_direction)
	#print("down_direction: ", down_direction)
	#print("left_direction: ", left_direction)
	#print("right_direction: ", right_direction)

func process_input() -> void:
	if Input.is_action_just_pressed("control_up"):
		#print("In Character Node: control_up")
		try_move(DIRECTION.UP)
		
	if Input.is_action_just_pressed("control_down"):
		#print("In Character Node: control_down")
		try_move(DIRECTION.DOWN)
		
	if Input.is_action_just_pressed("control_left"):
		#print("In Character Node: control_left")
		try_move(DIRECTION.LEFT)
		
	if Input.is_action_just_pressed("control_right"):
		#print("In Character Node: control_right")
		try_move(DIRECTION.RIGHT)
		
	if Input.is_action_just_pressed("control_shoulder_left"):
		#print("In Character Node: control_shoulder_left")
		rotate_camera(false)
		
	if Input.is_action_just_pressed("control_shoulder_right"):
		#print("In Character Node: control_shoulder_right")
		rotate_camera(true)
		
	if Input.is_action_just_pressed("control_a"):
		#print("In Character Node: control_a")
		map.interact(position)
		pass
		
	if Input.is_action_just_pressed("control_b"):
		#print("In Character Node: control_b")
		pass
		
	if Input.is_action_just_pressed("control_x"):
		#print("In Character Node: control_x")
		pass
		
	if Input.is_action_just_pressed("control_y"):
		#print("In Character Node: control_y")
		print("position: ",position)
		

func _process(delta: float) -> void:
	process_input()
