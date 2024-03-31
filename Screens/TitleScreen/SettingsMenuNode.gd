extends Control

signal item_selected

@onready var value_1: Label = $MarginContainer/VBoxContainer/HBoxContainer1/Value1
@onready var value_2: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Value2
@onready var value_3: Label = $MarginContainer/VBoxContainer/HBoxContainer3/Value3
@onready var save_and_return: Label = $"MarginContainer/VBoxContainer/Save and Return"
@onready var cursor: ColorRect = $"../Cursor"


func _on_save_and_return_item_selected() -> void:
	#save_and_return.text = "Not available!"
	var config = ConfigFile.new()
	config.set_value("MenuSettings", "cursor_trail", value_1.value)
	config.set_value("MenuSettings", "hide_gem_icon", value_2.value)
	config.set_value("MenuSettings", "movement_type", value_3.value)
	config.save("user://settings.cfg")
	Global.cursor_trail = value_1.value
	Global.hide_gem_icon = value_2.value
	Global.movement_type = value_3.value
	print("Saving global.movement_type as ", value_3.value)
	item_selected.emit()

func _on_return_item_selected() -> void:
	item_selected.emit()

func set_value1(value : bool):
	value_1.value = value

func set_value2(value : bool):
	value_2.value = value

func set_value3(value : bool):
	value_3.value = value

func _on_option_1_item_selected() -> void:
	value_1.toogle_value()
	cursor.set_particles_emission(value_1.value)

func _on_option_2_item_selected() -> void:
	value_2.toogle_value()
	cursor.set_gem_visibility(value_2.value)

func _on_option_3_item_selected() -> void:
	value_3.toogle_value()
