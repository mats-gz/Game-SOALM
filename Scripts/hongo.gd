extends CharacterBody2D

var vel = 40
var direc = 1  # -1 porque inicia mirando a la izquierda
var jugador_en_hitbox = false
var puede_atacar = true
var ref_jugador = null
var lastimado = false
var vida = 3  

var pos_inicial_x = 0  # Guardará la posición inicial del hongo

@onready var animacion_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var enemigo_lastimado: Timer = $EnemigoLastimado

func _ready():
	add_to_group("enemigo")
	pos_inicial_x = position.x

func _process(delta):
	# Movimiento
	position.x += delta * vel * direc

	# Verifica límites para cambiar de dirección
	if position.x >= pos_inicial_x + 40:
		direc = -1
		animacion_sprite.flip_h = false  # Como inicia mirando a la izquierda, no hace falta voltearlo
	elif position.x <= pos_inicial_x - 40:
		direc = 1
		animacion_sprite.flip_h = true

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("Protagonista"):
		jugador_en_hitbox = true
		ref_jugador = body
		if puede_atacar:
			puede_atacar = false
			vel = 0
			animacion_sprite.play("ataque")
			body.recibir_daño(10)
			$AtaqueCooldown.start()

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("Protagonista"):
		jugador_en_hitbox = false
		animacion_sprite.play("correr")
		vel = 40

func _on_ataque_cooldown_timeout():
	puede_atacar = true
	if jugador_en_hitbox:
		ref_jugador.recibir_daño(10)
	else:
		animacion_sprite.play("correr")
		vel = 40

func recibir_daño(cantidad):
	vel = 0
	animacion_sprite.play("lastimado")
	vida -= 1
	print("Hongo recibió ", cantidad, " de daño. Vida restante: ", vida)
	enemigo_lastimado.start()
	if vida == 0:
		animacion_sprite.play("muerte")  # Espera que termine la animación
		queue_free()

func _on_enemigo_lastimado_timeout():
	animacion_sprite.play("correr")
	vel = 40
