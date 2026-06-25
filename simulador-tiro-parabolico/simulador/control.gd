extends Control

@onready var rigidPelota = $rigidPelota
@onready var sombra = $rigidPelota/sombra

@onready var cameraPelota = $cameraPelota

@onready var lineEstela = $lineEstela
@onready var lineTrayectoria = $"canvasResultados/panelResultados/panelTrayectoria/lineTrayectoria"

@onready var spinBoxVO = $canvasDatos/panelDatos/spinBoxVO
@onready var spinBoxAngulo = $canvasDatos/panelDatos/spinBoxAngulo

@onready var animReposo = $jugador/animationReposo
@onready var animPatada = $jugador/animationPatada
@onready var animRebote = $rigidPelota/animationRebote

@onready var collisionSuelo = $staticSuelo/collisionSuelo
@onready var suelo = $staticSuelo

@onready var canvasResultados = $canvasResultados
@onready var labelAlcance = $canvasResultados/panelResultados/labelAlcance
@onready var labelAltura = $canvasResultados/panelResultados/labelAltura
@onready var labeTiempo = $canvasResultados/panelResultados/labelTiempo
@onready var labelVF = $canvasResultados/panelResultados/labelVF
@onready var labelGolpe = $canvasResultados/panelResultados/labelGolpe
@onready var btnAceptar = $canvasResultados/panelResultados/btnAceptar

@onready var btnCalcular = $canvasDatos/panelDatos/btnCalcular
@onready var btnObstaculo = $canvasDatos/panelDatos/btnObstaculo
@onready var btnReiniciar = $canvasDatos/panelDatos/btnReiniciar
@onready var btnQuitar = $canvasDatos/panelDatos/btnQuitar
@onready var btnRegresar = $canvasDatos/panelDatos/btnRegresar
@onready var btnAgregar = $canvasObstaculo/panelObstaculo/btnAgregar
@onready var btnCancelar = $canvasObstaculo/panelObstaculo/btnCancelar
@onready var btnInformacion = $canvasInformacion/btnInformacion

@onready var muro = $"stacticMuro"
@onready var collisionMuro = $"stacticMuro/collisionMuro"
@onready var canvasObstaculo = $"canvasObstaculo"
@onready var spinBoxAltura = $"canvasObstaculo/panelObstaculo/spinBoxAltura"
@onready var spinBoxDistancia = $"canvasObstaculo/panelObstaculo/spinBoxDistancia"

var velocidad_px = 0.0
var angulo_rad = 0.0
var tiempo = 0.0
var MAX_PUNTOS = 200
var grabando = false
var camara_fija = false
var aterrizo = false
var en_vuelo = false
var golpeo_muro = false
var puntosTrayectoria = []
const Y_SUELO = 1060

func _process(delta):
	sombra.global_rotation = 0
	sombra.global_position.x = rigidPelota.global_position.x
	sombra.global_position.y = Y_SUELO
	
func _ready():
	lineTrayectoria.top_level = false
	lineEstela.clear_points()
	lineEstela.top_level = true

func _physics_process(delta):
	if not camara_fija:
		cameraPelota.global_position.x = rigidPelota.global_position.x
	cameraPelota.global_position.y = 540
	collisionSuelo.global_position.x = cameraPelota.global_position.x
	
	var velocidad = rigidPelota.linear_velocity.length()
	
	if velocidad > 5 and not aterrizo:
		grabando = true
	if velocidad < 2 or aterrizo:
		grabando = false
	
	if grabando:
		tiempo += delta
		if tiempo > 0.01:
			var punto = rigidPelota.global_position
			lineEstela.add_point(punto)
			puntosTrayectoria.append(punto)
			tiempo = 0
			if lineEstela.get_point_count() > MAX_PUNTOS:
				lineEstela.remove_point(0)

func fijarCamara():
	if not en_vuelo:
		return
	grabando = false
	en_vuelo = false
	camara_fija = true
	aterrizo = true
	lineEstela.clear_points()
	$canvasResultados/panelResultados.mostrar()

func resetCompleto():
	puntosTrayectoria.clear()
	lineEstela.clear_points()
	grabando = false
	tiempo = 0.0
	aterrizo = false
	camara_fija = false
	en_vuelo = false

func resetEstela():
	lineEstela.clear_points()
	grabando = false
	tiempo = 0.0
	aterrizo = false
	golpeo_muro = false

func golpeoMuro():
	golpeo_muro = true
	
func bloquearBotones():
	btnCalcular.disabled = true
	btnObstaculo.disabled = true
	btnRegresar.disabled = true
	btnQuitar.disabled = true

func desbloquearBotones():
	btnCalcular.disabled = false
	btnObstaculo.disabled = false
	btnRegresar.disabled = false
	btnQuitar.disabled = false

func _input(event):

	if event.is_action_pressed("ui_espacio"):

		if canvasResultados.visible:
			if btnAceptar.visible and not btnAceptar.disabled:
				btnAceptar._on_pressed()

		elif canvasObstaculo.visible:
			if btnAgregar.visible and not btnAgregar.disabled:
				btnAgregar._on_pressed()

	if event.is_action_pressed("ui_enter"):
		if btnCalcular.visible and not btnCalcular.disabled:
			btnCalcular._on_pressed()

	if event.is_action_pressed("ui_r"):
		if btnReiniciar.visible and not btnReiniciar.disabled:
			btnReiniciar._on_pressed()

	if event.is_action_pressed("ui_m"):
		if btnQuitar.visible and not btnQuitar.disabled:
			btnQuitar._on_pressed()
		elif btnObstaculo.visible and not btnObstaculo.disabled:
			btnObstaculo._on_pressed()

	if event.is_action_pressed("ui_i"):
		if btnInformacion.visible and not btnInformacion.disabled:
			btnInformacion._on_pressed()

	if event.is_action_pressed("ui_escape"):
		if btnRegresar.visible and not btnRegresar.disabled:
				btnRegresar._on_pressed()

	if event.is_action_pressed("ui_c"):
		if canvasObstaculo.visible:
			if btnCancelar.visible and not btnCancelar.disabled:
				btnCancelar._on_pressed()
