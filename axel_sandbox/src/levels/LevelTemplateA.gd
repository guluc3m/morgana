extends Node2D

func _ready():
	GameSaver.load_game()
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
	
func set_owner(clueless_nodes):
	for clueless_node in clueless_nodes:
		print(clueless_node.owner)
		clueless_node.owner = self
		print(clueless_node.owner)
		#set_owner(clueless_node.get_children())

	
