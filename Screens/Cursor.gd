extends ColorRect

signal b_selected

@onready var gem: ColorRect = $Gem
@onready var cursor_vertical: ColorRect = $"../CursorVertical"
@onready var cursor_2_vertical: ColorRect = $"../CursorVertical/Cursor2Vertical"
@onready var cpu_particles_2d_vertical: CPUParticles2D = $"../CursorVertical/CPUParticles2DVertical"
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var new_cursor_position : Vector2
var new_cursor_vertical_position : Vector2
var new_cursor_2_vertical_original_position : Vector2
var cpu_particles_2d_vertical_position : Vector2
var new_cursor_size : Vector2
var new_cursor_vertical_size : Vector2
var new_gem_position : Vector2
@export var cursor_index := 0
@export var current_group : String:
	set(new_group):
		current_group = new_group
		cursor_index = 0
var options : Array

func _ready() -> void:
	update_options()
	update_cursor_pos()

func set_particles_emission(is_active : bool):
	cpu_particles_2d.emitting = is_active
	if cpu_particles_2d_vertical != null:
		cpu_particles_2d_vertical.emitting = is_active
	
func set_gem_visibility(is_active : bool):
	gem.visible = is_active

func update_options() -> void:
	if cpu_particles_2d_vertical != null:
		cpu_particles_2d_vertical_position = cpu_particles_2d_vertical.global_position
	if cursor_2_vertical != null:
		new_cursor_2_vertical_original_position = cursor_2_vertical.global_position
	#print("current_group: ",current_group)
	#print("options (before): ",options)
	options = get_tree().get_nodes_in_group(current_group)
	#print("options (after): ",options)

func update_cursor_pos():
	if cursor_index >= 0 and cursor_index < options.size():
		new_cursor_position = Vector2(position.x,options[cursor_index].global_position.y)
		new_cursor_size = Vector2(size.x, options[cursor_index].get_line_height())
		new_gem_position = Vector2(options[cursor_index].global_position.x + 970, new_cursor_size.y -47)
		var tween_cursor = create_tween().set_parallel(true)
		tween_cursor.tween_property(self, "global_position", new_cursor_position, 0.5)
		tween_cursor.tween_property(self, "size", new_cursor_size, 0.5)
		tween_cursor.tween_property(gem, "position", new_gem_position, 0.5)
		if current_group == "file_screen_name_input_node":
			new_cursor_vertical_position = Vector2(options[cursor_index].global_position.x,options[cursor_index].global_position.y-1000)
			new_cursor_vertical_size = Vector2(options[cursor_index].size.x, cursor_vertical.size.y)
			cpu_particles_2d_vertical_position = Vector2(new_cursor_vertical_position.x + new_cursor_vertical_size.x , cpu_particles_2d_vertical_position.y)
			var tween_cursor3 = create_tween().set_parallel(true)
			tween_cursor3.tween_property(cursor_vertical, "size", new_cursor_vertical_size, 0.5)
			tween_cursor3.tween_property(cursor_vertical, "global_position", new_cursor_vertical_position, 0.5)
			#tween_cursor3.tween_property(cpu_particles_2d_vertical, "global_position", cpu_particles_2d_vertical_position, 0.5)
			if cursor_2_vertical.size.x < cursor_vertical.size.x:
				cursor_2_vertical.global_position.x = cursor_vertical.global_position.x
				cursor_2_vertical.size.x = cursor_vertical.size.x
			else:
				cursor_2_vertical.size.x = 50.0
				

func _process(delta: float) -> void:
	var input := Vector2.ZERO
	if Input.is_action_just_pressed("control_up"):
		input.y -= 1
		#cursor_index -= 1
	if Input.is_action_just_pressed("control_down"):
		input.y += 1
		#cursor_index += 1
	if Input.is_action_just_pressed("control_left"):
		input.x -= 1
	if Input.is_action_just_pressed("control_right"):
		input.x += 1
	
	
	if current_group == "file_screen_name_input_node":
		cursor_vertical.visible = true
		if cursor_index + input.x + input.y * 13 < 0:
			cursor_index = 0
		elif cursor_index + input.x + input.y * 13 >= 69:
			cursor_index = 68
		else:
			cursor_index = cursor_index + input.x + input.y * 13
	else:
		if cursor_vertical != null:
			cursor_vertical.visible = false
		cursor_index += input.y
		if cursor_index< 0:
			cursor_index = options.size()-1
		elif cursor_index >= options.size():
			cursor_index = 0
	
	if Input.is_action_just_pressed("control_a"):
		if current_group == "file_screen_name_input_node" or current_group == "exploration_menu_quit_node":
			options[cursor_index].text_send()
		else:
			options[cursor_index].item_select()
		update_options()
	if Input.is_action_just_pressed("control_b"):
		b_selected.emit()
		update_options()
	if Input.is_action_just_pressed("control_x"):
		print("cursor_index: ",cursor_index)
		print("options[cursor_index].global_position.x: ", options[cursor_index].global_position.x)
	
	update_cursor_pos()
	#print(cursor_index)
