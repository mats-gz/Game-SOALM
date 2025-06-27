extends Node2D

@export var velocidad := 300
var direccion := Vector2.RIGHT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slime: Node2D = $"."

func _process(delta):
	position += direccion * velocidad * delta
	
		#Dar vuelta el sprite
	if direccion == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	elif direccion != Vector2.RIGHT:
		animated_sprite_2d.flip_h = true
		
func _on_body_entered(body):
	print("Colisión con: ", body.name)
	if body.is_in_group("Enemigos"):
		body.recibir_dano(1)  # Llama al método del enemigo
		queue_free()  # La bola desaparece al impactar
