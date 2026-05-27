extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed():
	Global.presionarBoton()
	get_tree().reload_current_scene()
