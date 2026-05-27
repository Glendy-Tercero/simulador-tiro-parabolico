extends Control

@onready var sliderVolumen = $sliderVolumen

func _ready():
	sliderVolumen.value = Global.volumen * 100
	sliderVolumen.value_changed.connect(_on_volumen_changed)

func _on_volumen_changed(valor):
	Global.setVolumen(valor / 100.0)
