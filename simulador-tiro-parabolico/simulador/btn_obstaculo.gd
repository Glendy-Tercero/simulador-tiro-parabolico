extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed():
	Global.presionarBoton()
	control.bloquearBotones()
	control.canvasObstaculo.visible = true
