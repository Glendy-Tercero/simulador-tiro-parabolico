extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed() -> void:
	Global.presionarBoton()
	control.desbloquearBotones()
	control.canvasObstaculo.visible = false
	
	control.collisionMuro.disabled = false
	control.btnObstaculo.visible = false
	control.btnQuitar.visible = true

	var distancia = control.spinBoxDistancia.value
	var altura = control.spinBoxAltura.value
	
	control.muro.visible = true
	control.muro.position.x = 248 + (distancia * 150)
	
	var sprite_base = control.muro.get_node("muro")
	for hijo in control.muro.get_parent().get_children():
		if hijo.name.begins_with("muroCopia"):
			hijo.queue_free()

	for i in range(1, altura):
		var copia = control.muro.duplicate()
		copia.name = "muroCopia" + str(i)
		copia.position = control.muro.position
		copia.position.y -= 150 * i
		copia.visible = true
		copia.z_index = -1
		copia.get_node("collisionMuro").disabled = false
		control.add_child(copia)
