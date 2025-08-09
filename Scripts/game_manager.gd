extends Node

var Moneda = 0
var Vidas = 3
@onready var puntaje: Label = $"../Personajes/Protagonista/Camera2D/Puntos/Panel/Puntaje"

func perder_vida():
	Vidas -= 1
	print("Te quedan" + str(Vidas) + "vidas.")
	if (Vidas == 0):
		get_tree().reload_current_scene()


func add_monedas():
	Moneda += 1
	print("Cantidad de Monedas: ", Moneda)
	puntaje.text = str(Moneda) + " Puntos"
	
