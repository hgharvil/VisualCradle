extends Control

@onready var cursor: ColorRect = $"2DElements/Cursor"
@onready var title_node: Control = $"2DElements/TitleNode"
@onready var start_node: Control = $"2DElements/StartNode"
@onready var main_menu_node: Control = $"2DElements/MainMenuNode"
@onready var settings_menu_node: Control = $"2DElements/SettingsMenuNode"

func _ready() -> void:
	Global.reset()
	load_settings()

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("An issue occured while loading settings! (title_screen)")
		return
	print("Loading settings succeeded! (title_screen)")
	for item in config.get_sections():
		var cursor_trail = config.get_value(item,"cursor_trail")
		var hide_gem_icon = config.get_value(item,"hide_gem_icon")
		var movement_type = config.get_value(item,"movement_type")
		settings_menu_node.set_value1(cursor_trail)
		settings_menu_node.set_value2(hide_gem_icon)
		settings_menu_node.set_value3(movement_type)
		cursor.set_particles_emission(cursor_trail)
		cursor.set_gem_visibility(hide_gem_icon)
		Global.cursor_trail = cursor_trail
		Global.hide_gem_icon = hide_gem_icon
		Global.movement_type = movement_type
	

func _on_press_a_button_label_item_selected() -> void:
	start_node.visible = false
	main_menu_node.visible = true
	cursor.current_group = "title_screen_main_menu_node"
	cursor.cursor_index = 0

func _on_game_start_label_item_selected() -> void:
	SceneTransition.change_scene_to_file("res://Screens/FileScreen/file_screen.tscn")

func _on_settings_label_item_selected() -> void:
	title_node.visible = false
	main_menu_node.visible = false
	settings_menu_node.visible = true
	cursor.current_group = "title_screen_settings_menu_node"
	cursor.cursor_index = 0
	load_settings_from_global()

func _on_settings_menu_node_item_selected() -> void:
	settings_menu_node.visible = false
	title_node.visible = true
	main_menu_node.visible = true
	cursor.current_group = "title_screen_main_menu_node"
	cursor.cursor_index = 1
	load_settings_from_global()

func _on_quit_label_item_selected() -> void:
	get_tree().quit()

func _on_cursor_b_selected() -> void:
	var menu = cursor.current_group.split("_")
	if menu[2] == "main":
		main_menu_node.visible = false
		start_node.visible = true
		cursor.current_group = "title_screen_start_node"
		cursor.cursor_index = 0
	elif menu[2] == "settings":
		_on_settings_menu_node_item_selected()

func load_settings_from_global():
	cursor.set_particles_emission(Global.cursor_trail)
	cursor.set_gem_visibility(Global.hide_gem_icon)
	

