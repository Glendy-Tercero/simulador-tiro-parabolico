extends Button

func _on_pressed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("ui_escape"):
		get_tree().quit()
