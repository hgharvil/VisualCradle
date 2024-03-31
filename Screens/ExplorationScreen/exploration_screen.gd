extends Node3D
@onready var exploration_menu: Control = $ExplorationMenu
@onready var character: Node3D = $Character

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("control_start"):
		print("start pressed!")
		character.set_process(false)
		exploration_menu.visible = true
		exploration_menu.set_process(true)

func _on_exploration_menu_focus_away_from_menu() -> void:
	exploration_menu.set_process(false)
	exploration_menu.visible = false
	exploration_menu.reset_cursor_position()
	character.set_process(true)

