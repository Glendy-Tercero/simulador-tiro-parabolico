extends Area2D

@onready var control = get_tree().root.get_node("Control")

func _ready():
	print(get_path())

func _on_body_entered(body: Node2D) -> void:
	if body.name == "rigidPelota":
		
		Global.patada()
		control.animRebote.play("animationRebote")
		
		control.puntosTrayectoria.clear()
		control.resetEstela()
		control.en_vuelo = true
		control.grabando = true
		
		var velocidad_px = control.spinBoxVO.value * 150.0
		var angulo_rad = deg_to_rad(control.spinBoxAngulo.value)
		
		body.sleeping = false
		body.linear_velocity = Vector2(
			velocidad_px * cos(angulo_rad),
			-velocidad_px * sin(angulo_rad)
		)
