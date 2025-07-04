extends Node2D

@export var velocidad := 300
var direccion := Vector2.RIGHT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	position += direccion * velocidad * delta
	
	if direccion == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func _on_hitbox_bola_body_entered(body):
	if body.is_in_group("enemigo"):
		if body.has_method("recibir_daño"):
			body.recibir_daño(3)
		queue_free()
