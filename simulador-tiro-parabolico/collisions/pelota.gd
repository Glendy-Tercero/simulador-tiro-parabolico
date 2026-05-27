extends RigidBody2D

@onready var control = get_tree().root.get_node("Control")

func _ready():
	contact_monitor = true
	max_contacts_reported = 1

func _on_body_entered(body):
	if not control.en_vuelo:
		return
	Global.rebote()
	if body.name == "staticSuelo":
		control.grabando = false
		control.fijarCamara()
	elif "muro" in body.name.to_lower():
		control.golpeoMuro()
		control.grabando = false
		control.fijarCamara()
