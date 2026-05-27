extends Button

@onready var control = get_tree().root.get_node("Control")

func _ready():
	print(get_path())

func _on_pressed():
	Global.presionarBoton()
	control.bloquearBotones()
	control.velocidad_px = control.spinBoxVO.value * 150.0
	control.angulo_rad = deg_to_rad(control.spinBoxAngulo.value)
	
	control.animReposo.stop()
	control.animPatada.queue("animationPatada")
	control.animPatada.animation_finished.connect(_on_patada_terminada, CONNECT_ONE_SHOT)

func _on_patada_terminada(anim_name):
	control.animPatada.stop()
	control.animReposo.play("animationReposo")
