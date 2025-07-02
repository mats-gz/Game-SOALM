extends Node

var Memoria = 0
var Vidas = 3

func perder_vida():
	Vidas -= 1
	print("Te quedan" + str(Vidas) + "vidas.")
	if (Vidas == 0):
		get_tree().reload_current_scene()


func add_memoria():
	Memoria += 1
	print("Cantidad de Memoria: ", Memoria)
