extends Control

signal focus_away_from_menu

@onready var cursor: ColorRect = $Cursor
@onready var menu_path_node: Control = $MenuPathNode
@onready var base_menu_node: Control = $BaseMenuNode
@onready var notes_node: Control = $NotesNode
@onready var memories_node: Control = $MemoriesNode
@onready var inventory_node: Control = $InventoryNode
@onready var equipment_node: Control = $EquipmentNode
@onready var settings_node: Control = $SettingsNode
@onready var save_node: Control = $SaveNode
@onready var quit_node: Control = $QuitNode
@onready var confirmation_node: Control = $ConfirmationNode

var is_quit_to_menu := false

func _ready() -> void:
	set_process(false)

func _on_return_label_item_selected() -> void:
	emit_signal("focus_away_from_menu")

func reset_cursor_position():
	cursor.cursor_index = 0

func _on_quit_label_item_selected() -> void:
	confirmation_node.visible = false
	quit_node.visible = true
	cursor.current_group = "exploration_menu_quit_node"



func _on_return_label_text_sent(text: Variant) -> void:
	if text == "Return":
		_on_submenu_return_label_item_selected()

func enable_default_visibility():
	base_menu_node.visible = true
	notes_node.visible = false
	memories_node.visible = false
	inventory_node.visible = false
	equipment_node.visible = false
	settings_node.visible = false
	save_node.visible = false
	quit_node.visible = false
	confirmation_node.visible = false


func _on_quit_game_labels_text_sent(text: Variant) -> void:
	if text == "Quit to Main Menu":
		is_quit_to_menu = true
	elif text == "Quit Game":
		is_quit_to_menu = false
	
	confirmation_node.visible = true
	cursor.current_group = "exploration_menu_confirmation_node"


func _on_yes_label_item_selected() -> void:
	if is_quit_to_menu:
		SceneTransition.change_scene_to_file("res://Screens/TitleScreen/title_screen.tscn")
	else:
		get_tree().quit()


func _on_notes_label_item_selected() -> void:
	notes_node.visible = true
	cursor.current_group = "exploration_menu_notes_node"


func _on_submenu_return_label_item_selected() -> void:
		enable_default_visibility()
		cursor.current_group = "exploration_menu_base_menu_node"


func _on_memories_label_item_selected() -> void:
	memories_node.visible = true
	cursor.current_group = "exploration_menu_memories_node"


func _on_inventory_label_item_selected() -> void:
	inventory_node.visible = true
	cursor.current_group = "exploration_menu_inventory_node"


func _on_equipment_label_item_selected() -> void:
	equipment_node.visible = true
	cursor.current_group = "exploration_menu_equipment_node"


func _on_settings_label_item_selected() -> void:
	settings_node.visible = true
	cursor.current_group = "exploration_menu_settings_node"


func _on_save_label_item_selected() -> void:
	save_node.visible = true
	cursor.current_group = "exploration_menu_save_node"


func _on_save_label() -> void:
	save_file()
	_on_submenu_return_label_item_selected()

func save_file():
	var save_game = FileAccess.open("user://savegame"+str(Global.current_file_number)+".save", FileAccess.WRITE)
	var save_dict = {
		"file_name" : Global.current_file_name,
		"player_coordinates.x" : Global.player_coordinates.x,
		"player_coordinates.y" : Global.player_coordinates.y,
		"player_coordinates.z" : Global.player_coordinates.z,
		"file_number" : Global.current_file_number
	}
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	print("File"+str(Global.current_file_number)+" save data updated!")
