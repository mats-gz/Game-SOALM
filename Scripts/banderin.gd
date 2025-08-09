extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	# Verificamos que sea el jugador
	if body.has_method("Protagonista"):
		if game_manager.Moneda >= 45:
			print("¡Ganaste!")
			get_tree().change_scene_to_file("res://Escenas/Ganaste.tscn") # Escena de victoria
		else:
			print("Necesitas más de 45 puntos para terminar el juego")
