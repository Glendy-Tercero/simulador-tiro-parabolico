extends StaticBody2D

@onready var sueloSprite = $suelo
@onready var colision = $collisionSuelo
@onready var camara = get_tree().root.get_node("Control/cameraPelota")

var ancho = 1920.0
var copias = []

func _ready():
	for i in range(1, 6):
		var copia = sueloSprite.duplicate()
		copia.position.x = sueloSprite.position.x + (ancho * i)
		if i % 2 != 0:
			copia.flip_h = true
		add_child(copia)
		copias.append(copia)

func _physics_process(delta):
	var cam_x = camara.global_position.x

	var ultima = copias.back()
	if cam_x + 1920 > ultima.global_position.x:
		var nueva = sueloSprite.duplicate()
		nueva.position.x = ultima.position.x + ancho
		if copias.size() % 2 != 0:
			nueva.flip_h = true
		add_child(nueva)
		copias.append(nueva)
