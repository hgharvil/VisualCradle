extends Node

var player_coordinates := Vector3(3,0,3)
var cursor_trail : bool = true
var hide_gem_icon : bool = true
var movement_type : bool = true
var current_file_number := 0:
	set(new_number):
		current_file_number = new_number
		print("UPDATING GLOBAL FILE NUMBER TO: ", current_file_number)
var current_file_name := "No data"

func reset():
	player_coordinates = Vector3(3,0,3)
	cursor_trail = true
	hide_gem_icon = true
	movement_type = true
	current_file_number = 0
	current_file_name = "No Data"
