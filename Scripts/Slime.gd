extends Node2D

const vel = 40
var direc = 1
@onready var ray_cast_der: RayCast2D = $RayCastDer
@onready var ray_cast_izq: RayCast2D = $RayCastIzq
@onready var animacion_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bola_fuego: Node2D = $"."
var vida := 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#region Direccion de movimiento del Slime

	if ray_cast_der.is_colliding():
		direc = -1
		animacion_sprite.flip_h = true
	if ray_cast_izq.is_colliding():
		direc = 1
		animacion_sprite.flip_h = false
		
	position.x += delta * vel * direc
	
#endregion

func recibir_dano(cantidad):
	vida -= cantidad
	if vida <= 0:
		morir()

func morir():
	queue_free()  # O podés reproducir una animación y luego desaparecer
