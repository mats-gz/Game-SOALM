extends HBoxContainer

@onready var corazon1 := $Corazon1
@onready var corazon2 := $Corazon2
@onready var corazon3 := $Corazon3
@onready var corazones: Node2D = $"../.."
@onready var prota = get_tree().get_first_node_in_group("Protagonista")

func _process(delta):
	if prota.global_position.y >= 70:
		visible = false
	else:
		visible = true


func actualizar_vidas(vida: float):
	if vida <= 80:
		$Corazon3.texture = preload("res://Assets/sprites/Mapa/corazon_medio.png")
	if vida <= 66:
		$Corazon3.texture = preload("res://Assets/sprites/Mapa/corazon_vacio.png")
	if vida <= 50:
		$Corazon2.texture = preload("res://Assets/sprites/Mapa/corazon_medio.png")
	if vida <= 33:
		$Corazon2.texture = preload("res://Assets/sprites/Mapa/corazon_vacio.png")
	if vida <= 18:
		$Corazon1.texture = preload("res://Assets/sprites/Mapa/corazon_medio.png")
	if vida <= 0:
		$Corazon1.texture = preload("res://Assets/sprites/Mapa/corazon_vacio.png")
