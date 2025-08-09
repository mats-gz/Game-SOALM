extends Control

@onready var game_manager: Node = %GameManager

func _on_jugar_devuelta_pressed():
	get_tree().change_scene_to_file("res://Escenas/Nivel-1.tscn")
