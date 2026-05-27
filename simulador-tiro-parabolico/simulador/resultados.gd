extends Panel

@onready var control = get_tree().root.get_node("Control")
@onready var lineTrayectoria = $panelTrayectoria/lineTrayectoria

func _ready():
	visible = false
	lineTrayectoria.top_level = false

func mostrar():
	dibujarTrayectoria()
	
	if control.golpeo_muro:
		calcularSemiparabolico()
	else:
		calcularParabolico()
	
	mostrarGolpe()
	
	await get_tree().create_timer(1.0).timeout
	get_parent().visible = true
	visible = true
	Global.ventanaResultados()

func dibujarTrayectoria():
	control.lineTrayectoria.clear_points()
	
	var puntos = control.puntosTrayectoria
	
	if puntos.size() > 0:
		var min_x = puntos[0].x
		var max_x = puntos[puntos.size()-1].x
		var min_y = puntos[0].y
		var max_y = puntos[0].y
		
		for p in puntos:
			if p.y < min_y: min_y = p.y
			if p.y > max_y: max_y = p.y
		
		var rango_x = max_x - min_x
		var rango_y = max_y - min_y
		
		if rango_x == 0: rango_x = 1
		if rango_y == 0: rango_y = 1
		
		var escala = min(400.0 / rango_x, 100.0 / rango_y)
		var offset_x = (400 - rango_x * escala) / 2 + 10
		var offset_y = (120 - rango_y * escala) / 2 + 10

		for p in puntos:
			var nx = (p.x - min_x) * escala + offset_x
			var ny = (p.y - min_y) * escala + offset_y
			lineTrayectoria.add_point(Vector2(nx, ny))

func calcularParabolico():
	var v0 = control.spinBoxVO.value
	var angulo = deg_to_rad(control.spinBoxAngulo.value)
	var g = 9.8
	
	var alcance = (v0 * v0 * sin(2 * angulo)) / g
	var altura = (v0 * v0 * pow(sin(angulo), 2)) / (2 * g)
	var tiempo = (2 * v0 * sin(angulo)) / g
	var rad = deg_to_rad(angulo)
	var vx = v0 * cos(rad)
	var vy = v0 * sin(rad) - g * tiempo
	var vf = sqrt(vx * vx + vy * vy)
	
	control.labelAlcance.text = "Alcance: %.2f m" % alcance
	control.labelAltura.text = "Altura máxima: %.2f m" % altura
	control.labeTiempo.text = "Tiempo de vuelo: %.2f s" % tiempo
	control.labelVF.text = "Velocidad final: %.2f m/s" % vf

func calcularSemiparabolico():
	var v0 = control.spinBoxVO.value
	var angulo = deg_to_rad(control.spinBoxAngulo.value)
	var g = 9.8
	var distancia = control.spinBoxDistancia.value
	
	var tiempo_muro = distancia / (v0 * cos(angulo))
	var altura_impacto = v0 * sin(angulo) * tiempo_muro - 0.5 * g * tiempo_muro * tiempo_muro
	var rad = deg_to_rad(angulo)
	var vx = v0 * cos(rad)
	var vy = v0 * sin(rad) - g * tiempo_muro
	var vf = sqrt(vx * vx + vy * vy)
	
	control.labelAlcance.text = "Alcance al muro: %.2f m" % distancia
	control.labelAltura.text = "Altura de impacto: %.2f m" % altura_impacto
	control.labeTiempo.text = "Tiempo al muro: %.2f s" % tiempo_muro
	control.labelVF.text = "Velocidad: %.2f m/s" % vf

func mostrarGolpe():
	if control.muro.visible:
		control.labelGolpe.visible = true
		if control.golpeo_muro:
			control.labelGolpe.text = "Golpeó el muro: Sí"
		else:
			control.labelGolpe.text = "Golpeó el muro: No"
	else:
		control.labelGolpe.visible = false
