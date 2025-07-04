extends CharacterBody2D

var vel = 40
var direc = 1
var jugador_en_hitbox = false
var puede_atacar = true
var ref_jugador = null
var vida = 3  # Vida o cantidad de impactos que puede recibir

@onready var ray_cast_der: RayCast2D = $RayCastDer
@onready var ray_cast_izq: RayCast2D = $RayCastIzq
@onready var animacion_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var tile_map: TileMap = $Mapa/TileMap

func _ready():
	add_to_group("enemigo")  # IMPORTANTE para que la bola detecte este nodo como enemigo

func _process(delta):
	if ray_cast_der.is_colliding():
		direc = -1
		animacion_sprite.flip_h = true
	if ray_cast_izq.is_colliding():
		direc = 1
		animacion_sprite.flip_h = false
		
	position.x += delta * vel * direc

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

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("Protagonista"):
		jugador_en_hitbox = false
		animacion_sprite.play("idle")
		vel = 40

func _on_ataque_cooldown_timeout():
	puede_atacar = true
	if jugador_en_hitbox == true:
		ref_jugador.recibir_daño(10)
	else:
		animacion_sprite.play("idle")
		vel = 40

func recibir_daño(cantidad):
	vida -= 1  # O también vida -= cantidad si querés usar daño variable
	print("Enemigo recibió ", cantidad, " de daño. Vida restante: ", vida)
	if vida <= 0:
		queue_free()  # Destruye el enemigo al recibir 3 impactos
