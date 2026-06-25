extends Button

func _on_pressed() -> void:
	Global.presionarBoton()
	get_tree().change_scene_to_file("res://information/information.tscn")
