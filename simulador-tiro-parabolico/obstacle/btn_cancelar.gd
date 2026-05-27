extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed() -> void:
	Global.presionarBoton()
	control.desbloquearBotones()
	control.canvasObstaculo.visible = false
