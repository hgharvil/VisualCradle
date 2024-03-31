extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("SplashItems")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneTransition.change_scene_to_file("res://Screens/TitleScreen/title_screen.tscn")
