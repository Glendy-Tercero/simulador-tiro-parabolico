extends Button

func _input(event):
	if event.is_action_pressed("ui_escape"):
		_on_pressed()

func _on_pressed() -> void:
	Global.presionarBoton()
	get_tree().change_scene_to_file("res://simulador/simulador.tscn")
