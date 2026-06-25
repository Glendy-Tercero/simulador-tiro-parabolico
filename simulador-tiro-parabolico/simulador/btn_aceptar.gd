extends Button

@onready var control = get_tree().root.get_node("Control")

func _on_pressed():
	
	Global.presionarBoton()
	control.desbloquearBotones()
	
	control.en_vuelo = false
	control.grabando = false
	control.camara_fija = false
	control.puntosTrayectoria.clear()
	control.resetEstela()
	control.canvasResultados.visible = false

	control.rigidPelota.freeze = true
	control.rigidPelota.linear_velocity = Vector2.ZERO
	control.rigidPelota.angular_velocity = 0

	await get_tree().process_frame

	control.rigidPelota.global_position = Vector2(248, 1037)
	control.rigidPelota.rotation = 0
	control.cameraPelota.global_position = Vector2(540, 1920)
	control.collisionSuelo.global_position.x = control.cameraPelota.global_position.x

	control.rigidPelota.freeze = false
	control.rigidPelota.sleeping = true
	
