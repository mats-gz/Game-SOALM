extends Panel

@onready var prota = get_tree().get_first_node_in_group("Protagonista")

func _process(delta):
	if prota.global_position.y >= 70:
		visible = false
	else:
		visible = true
