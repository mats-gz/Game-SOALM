extends Control

func _on_play_pressed ():
	get_tree().change_scene_to_file("res://Escenas/Nivel-1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
