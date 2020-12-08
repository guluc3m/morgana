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
				_target.mouse_over = true
				# Esto está por si se quiere pintar algo sobre el enemigo
				# y para saber que sigue funcionando y no hemos roto el apuntar
				_target.emit_signal("card_target")
				get_tree().call_group("card", "get_target", _target)
				


func _on_MouseCollision_area_exited(area):
	for _target in get_tree().get_nodes_in_group("targeteable"):
		if _target.mouse_over:
			_target.mouse_over = false
			_target.emit_signal("not_card_target")
			get_tree().call_group("card", "get_target", false)
