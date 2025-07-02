extends Node2D

@export var velocidad := 300
var direccion := Vector2.RIGHT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	position += direccion * velocidad * delta
	
		#Dar vuelta el sprite
	if direccion == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	elif direccion != Vector2.RIGHT:
		animated_sprite_2d.flip_h = true
