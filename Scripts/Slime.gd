extends Node2D

const vel = 40
var direc = 1
@onready var ray_cast_der: RayCast2D = $RayCastDer
@onready var ray_cast_izq: RayCast2D = $RayCastIzq
@onready var animacion_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_der.is_colliding():
		direc = -1
		animacion_sprite.flip_h = true
	if ray_cast_izq.is_colliding():
		direc = 1
		animacion_sprite.flip_h = false
		
	position.x += delta * vel * direc
