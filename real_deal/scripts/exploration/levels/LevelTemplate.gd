extends Node2D

func _ready():
	var r = get_tree().get_nodes_in_group("Sensitive")
	GameSaver.load_game()
	r = get_tree().get_nodes_in_group("Sensitive")
	print("jajaja")
	set_owner(get_tree().get_nodes_in_group("Sensitive"))
	print("oooooooooooooooo")
	"""
	var player = get_tree().get_root().find_node("Player", true, false)
	var chest = get_tree().get_root().find_node("EmptyChest", true, false)
	$Player.disconnect("item_collision", $EmptyChest, "_on_Player_item_collision")
	print(player.connect("item_collision", chest, "_on_Player_item_collision"))
	$Player.disconnect("item_collision", $FullChest, "_on_Player_item_collision")
	print($Player.connect("item_collision", $FullChest, "_on_Player_item_collision"))
	#$Player.connect("open_door", $Door, "_on_Player_open_door")
	"""

# No recuerdo para que valia esto
func set_owner(clueless_nodes):
	for clueless_node in clueless_nodes:
		print(clueless_node.owner)
		clueless_node.owner = self
		print(clueless_node.owner)
		#set_owner(clueless_node.get_children())

func update_data(data):
	""" Esta función tiene la finalidad de ajustar ciertos objetos a nuevos estados.
	Por ejemplo, al volver a la escena de exploración tras ganar un duelo, el grupo
	de enemigos ha desaparecido y el jugador a sufrido cambios en su vida, y probablemente
	en su cantidad de experiencia o botín.
	"""
	var r = get_tree().get_nodes_in_group("Sensitive")
	
	_update_player(data)
	_update_enemies(data)
	
func _update_player(data):
	var player = get_tree().get_root().find_node("Player", true, false)
	if data:
		$Player.caca(data["health"])
		print($Player.health)
	
	
func _update_enemies(data):
	var enemy = get_tree().get_root().find_node("EnemyOne", true, false)
	if data["enemy_defeat"]:
		enemy.queue_free()
