extends Area2D


func _ready():
	set_position(get_global_mouse_position())


func _process(delta):
	# Sigue al ratón
	set_position(get_global_mouse_position())


func _on_MouseCollision_area_entered(area):
	# Truco para hacer colisión con los enemigos cuando se está apuntando con
	# una carta
	for _target in get_tree().get_nodes_in_group("targeteable"):
		if area == _target:
			if not _target.mouse_over:
				print("PREMIO!")
				_target.mouse_over = true
				_target.emit_signal("card_target")
		else:
			_target.mouse_over = false
			# TODO: De alguna forma hay que "destargetear" al enemigo
			# _target.emit_signal("not_card_target")
