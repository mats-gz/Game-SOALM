extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -260.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const ATAQUE_BASICO = preload("res://Escenas/Poderes/BolaFuego.tscn")
@onready var pos_disparo: Marker2D = $PosDisparo


func _input(event):
	
#region Disparo con Click / Ataq. Básico
	if event.is_action_pressed("primer_ataque"):
		var bola = ATAQUE_BASICO.instantiate()
		bola.position = pos_disparo.global_position
		bola.direccion = Vector2.LEFT if animated_sprite.flip_h else Vector2.RIGHT
		get_tree().current_scene.add_child(bola)
#endregion

func _physics_process(delta: float) -> void:
#region Gravedad Juego

	# Añadir gravedad al juego.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
#endregion

#region Movimiento del Jugador
	# Acción de saltar.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Obtener la dirección de movimiento del jugador.
	var direction := Input.get_axis("mover_der", "mover_izq")

	#Dar vuelta el sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Animaciones
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("IDLE - Prota")
		else:
			animated_sprite.play("CORRER - Prota")
	else:
		animated_sprite.play("SALTO - Prota")
	
	#Definir la dirección del sprite
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
#endregion
