extends Label

signal item_selected
signal text_sent(text)

func item_select():
	emit_signal("item_selected")

func text_send():
	emit_signal("text_sent", text)
