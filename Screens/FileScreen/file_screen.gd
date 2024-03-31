extends Control

@onready var cursor: ColorRect = $"2DElements/Cursor"
@onready var file_select_node: Control = $"2DElements/FileSelectNode"
@onready var name_input_node: Control = $"2DElements/NameInputNode"
@onready var name_output_label: Label = $"2DElements/NameInputNode/MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/NameOutputLabel"
@onready var output_char_number_label: Label = $"2DElements/NameInputNode/MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer2/OutputCharNumberLabel"
@onready var data_1: Label = $"2DElements/FileSelectNode/MarginContainer/VBoxContainer/HBoxContainer1/Data1"
@onready var data_2: Label = $"2DElements/FileSelectNode/MarginContainer/VBoxContainer/HBoxContainer2/Data2"
@onready var data_3: Label = $"2DElements/FileSelectNode/MarginContainer/VBoxContainer/HBoxContainer3/Data3"

var selected_file : int

func _ready() -> void:
	load_settings_from_global()
	load_files()

func load_settings_from_global():
	cursor.set_particles_emission(Global.cursor_trail)
	cursor.set_gem_visibility(Global.hide_gem_icon)

func load_files():
	if FileAccess.file_exists("user://savegame1.save"):
		var save_game = FileAccess.open("user://savegame1.save", FileAccess.READ)
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue
			var load_data = json.get_data()
			data_1.text = load_data["file_name"]
			data_1.is_empty = false
	if FileAccess.file_exists("user://savegame2.save"):
		var save_game = FileAccess.open("user://savegame2.save", FileAccess.READ)
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue
			var load_data = json.get_data()
			data_2.text = load_data["file_name"]
			data_2.is_empty = false
	if FileAccess.file_exists("user://savegame3.save"):
		var save_game = FileAccess.open("user://savegame3.save", FileAccess.READ)
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue
			var load_data = json.get_data()
			data_3.text = load_data["file_name"]
			data_3.is_empty = false
	
	

func _on_return_item_selected() -> void:
	SceneTransition.change_scene_to_file("res://Screens/TitleScreen/title_screen.tscn")


func _on_file_1_item_selected() -> void:
	selected_file = 1
	if data_1.is_empty:
		new_game()
	else:
		load_game()


func _on_file_2_item_selected() -> void:
	selected_file = 2
	if data_2.is_empty:
		new_game()
	else:
		load_game()


func _on_file_3_item_selected() -> void:
	selected_file = 3
	if data_3.is_empty:
		new_game()
	else:
		load_game()

func load_game():
	load_global()
	SceneTransition.change_scene_to_file("res://Screens/ExplorationScreen/exploration_screen.tscn")

func load_global():
	var save_game = FileAccess.open("user://savegame"+str(selected_file)+".save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var load_data = json.get_data()
		Global.current_file_name = load_data["file_name"]
		Global.player_coordinates.x = load_data["player_coordinates.x"]
		Global.player_coordinates.y = load_data["player_coordinates.y"]
		Global.player_coordinates.z = load_data["player_coordinates.z"]
		Global.current_file_number = load_data["file_number"]

func new_game():
	file_select_node.visible = false
	name_input_node.visible = true
	cursor.current_group = "file_screen_name_input_node"


func _on_letter_label_text_sent(text: Variant) -> void:
	if text.length() == 1:
		print("selected letter: ", text)
		if int(output_char_number_label.text) < 20:
			name_output_label.text += text
			var number = int(output_char_number_label.text)
			number += 1
			output_char_number_label.text = str(number)
	elif text == "Space":
		print("selected button: ", text)
		if int(output_char_number_label.text) < 20:
			name_output_label.text += " "
			var number = int(output_char_number_label.text)
			number += 1
			output_char_number_label.text = str(number)
	elif text == "Backspace":
		print("selected button: ", text)
		if int(output_char_number_label.text) > 0:
			name_output_label.text = name_output_label.text.left(name_output_label.text.length()-1)
			var number = int(output_char_number_label.text)
			number -= 1
			output_char_number_label.text = str(number)
	elif text == "Confirm":
		var player_name = name_output_label.text
		if player_name.length() > 0:
			save_file(player_name)
			SceneTransition.change_scene_to_file("res://Screens/ExplorationScreen/exploration_screen.tscn")
	elif text == "Return":
		_on_return_item_selected()

func save_file(file_name: String):
	var save_game = FileAccess.open("user://savegame"+str(selected_file)+".save", FileAccess.WRITE)
	var save_dict = {
		"file_name" : file_name,
		"player_coordinates.x" : Global.player_coordinates.x,
		"player_coordinates.y" : Global.player_coordinates.y,
		"player_coordinates.z" : Global.player_coordinates.z,
		"file_number" : selected_file
	}
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	Global.current_file_name = file_name
	Global.current_file_number = selected_file
	
	print("File"+str(selected_file)+" save data created!")
