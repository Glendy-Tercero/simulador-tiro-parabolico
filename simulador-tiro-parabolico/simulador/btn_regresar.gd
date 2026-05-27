extends Button


func _input(event):
	if event.is_action_pressed("ui_escape"):
		get_tree().change_scene_to_file("res://main/main.tscn")

func _on_pressed() -> void:
	Global.presionarBoton()
	get_tree().change_scene_to_file("res://main/main.tscn")
