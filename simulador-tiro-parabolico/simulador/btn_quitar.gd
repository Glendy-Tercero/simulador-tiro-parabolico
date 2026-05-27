extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed():
	Global.presionarBoton()
	control.desbloquearBotones()
	
	control.btnObstaculo.visible = true
	control.btnQuitar.visible = false
	
	control.collisionMuro.disabled = true
	control.canvasObstaculo.visible = false
	
	control.muro.visible = false
	for hijo in control.get_children():
		if hijo.name.begins_with("muroCopia"):
			hijo.queue_free()
