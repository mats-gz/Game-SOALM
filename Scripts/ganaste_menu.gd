extends Control


@onready var puntos: Label = $VBoxContainer/Puntos

func _on_jugar_devuelta_pressed():
	get_tree().change_scene_to_file("res://Escenas/Nivel-1.tscn")

func _ready():
	puntos.text = "Has obtenido " + str(GameManager.Moneda) + " Puntos"
