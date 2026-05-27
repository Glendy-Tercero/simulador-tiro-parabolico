extends Node

var volumen = 0.25
var audioFondo: AudioStreamPlayer
var audioBoton: AudioStreamPlayer
var audioResultados: AudioStreamPlayer
var audioPelota: AudioStreamPlayer
var audioRebote: AudioStreamPlayer

func _ready():
	audioFondo = AudioStreamPlayer.new()
	audioFondo.stream = load("res://sounds/little_penguin.mp3")
	audioFondo.volume_db = linear_to_db(0.25)
	add_child(audioFondo)
	audioFondo.play()
	audioFondo.finished.connect(func(): audioFondo.play())
	
	audioBoton = AudioStreamPlayer.new()
	audioBoton.stream = load("res://sounds/bubble.mp3")
	add_child(audioBoton)
	
	audioResultados = AudioStreamPlayer.new()
	audioResultados.stream = load("res://sounds/win.mp3")
	add_child(audioResultados)
	
	audioPelota = AudioStreamPlayer.new()
	audioPelota.stream = load("res://sounds/ball.mp3")
	add_child(audioPelota)

	audioRebote = AudioStreamPlayer.new()
	audioRebote.stream = load("res://sounds/rebound.mp3")
	add_child(audioRebote)

func setVolumen(valor):
	volumen = valor
	audioFondo.volume_db = linear_to_db(valor)

func presionarBoton():
	audioBoton.play()

func ventanaResultados():
	audioResultados.play()

func patada():
	audioPelota.play()

func rebote():
	audioRebote.play()
