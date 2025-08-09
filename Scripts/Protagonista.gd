extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -260.0
var vida = 100
var cooldown_q = true
var estado = "normal"
var enemigo = null

# Variables de salto
var max_saltos = 2
var saltos_realizados = 0

#region Variables externas
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const ataque_basico = preload("res://Escenas/Poderes/BolaFuego.tscn")
@onready var pos_disparo: Marker2D = $PosDisparo
@onready var caja_corazones := get_node("Camera2D/Corazones/Corazones/CajaCorazones")
@onready var kill_area: Area2D = $"../../Mapa/KillArea"
@onready var estado_lastimado: Timer = $EstadoLastimado
#endregion


func _input(event):
	#region Disparo con Q / Ataq. Básico
	if event.is_action_pressed("primer_ataque"):
		var bola = ataque_basico.instantiate()
		bola.z_index = 10
		bola.position = pos_disparo.global_position
		bola.direccion = Vector2.LEFT if animated_sprite.flip_h else Vector2.RIGHT
		get_tree().current_scene.add_child(bola)
	#endregion


func _physics_process(delta):
	#region Gravedad Juego
	# Añadir gravedad al juego.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#endregion

	# Reiniciar contador de saltos al tocar el suelo
	if is_on_floor():
		saltos_realizados = 0

	#region Movimiento del Jugador
	# Acción de saltar (doble salto)
	if Input.is_action_just_pressed("salto") and saltos_realizados < max_saltos:
		velocity.y = JUMP_VELOCITY
		saltos_realizados += 1

	# Obtener la dirección de movimiento del jugador.
	var direction := Input.get_axis("mover_der", "mover_izq")

	# Dar vuelta el sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animaciones
	if estado != "lastimado":
		# Animaciones normales
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("IDLE - Prota")
			else:
				animated_sprite.play("CORRER - Prota")
		else:
			animated_sprite.play("SALTO - Prota")

	# Definir la dirección del sprite
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	#endregion


#region Funciones de la Hitbox del Protagonista
# Funcion que se activa una vez algo entra dentro de la hitbox del prota
func _on_player_hitbox_body_entered(body):
	if body.has_method("Enemigo"):
		enemigo = body

# Funcion que se activa una vez algo salió de la hitbox del prota.
func _on_player_hitbox_body_exited(body):
	if body.has_method("Enemigo"):
		estado = "normal"
#endregion


func recibir_daño(num):
	#region Función que se invoca cada que un enemigo le hace daño.
	vida -= num
	estado = "lastimado"
	$AnimatedSprite2D.play("lastimado")
	$EstadoLastimado.start()
	print("Tu personaje tiene: ", vida, " de vida")

	caja_corazones.actualizar_vidas(vida)
	if vida <= 0:
		kill_area._on_body_entered(self)
	#endregion

func _on_estado_lastimado_timeout():
	estado = "normal"


#region Función declarar protagonista
func Protagonista():
	pass
#endregion
