extends CharacterBody2D

var vel = 40
var direc = 1
var jugador_en_hitbox = false
var puede_atacar = true
var ref_jugador = null
#region Variables externas declaradas.
@onready var ray_cast_der: RayCast2D = $RayCastDer
@onready var ray_cast_izq: RayCast2D = $RayCastIzq
@onready var animacion_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var protagonista: CharacterBody2D = $"."
#endregion


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

#Si el enemigo entra al area para atacar
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("Protagonista"):
		jugador_en_hitbox = true
		ref_jugador = body
		if puede_atacar == true:
			puede_atacar = false
			vel = 0
			animacion_sprite.play("ataque")
			body.recibir_daño(10)
			$AtaqueCooldown.start()

#Se activa una vez el protagonista salga de la hitbox, para continuar su estado normal
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("Protagonista"):
		jugador_en_hitbox = false
		animacion_sprite.play("idle")
		vel = 40

#Se activa una vez el timer de 0.6s llegue al final
func _on_ataque_cooldown_timeout():
	puede_atacar = true
	if jugador_en_hitbox == true:
		ref_jugador.recibir_daño(10)
	else:
		animacion_sprite.play("idle")
		vel = 40

#region Declarar Enemigo
#Función para declarar enemigos.
func Enemigo():
	pass
#endregion
