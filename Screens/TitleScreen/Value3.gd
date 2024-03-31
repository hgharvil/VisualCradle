extends Label

@export var value : bool = true:
	set(new_value):
		value = new_value
		if value:
			text = "A"
		else:
			text = "B"

func toogle_value() -> void:
	value = !value
