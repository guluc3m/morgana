extends Node2D

var player = ""
var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_process(true)
	
	player = load("res://dani_sandbox/scenes/battle/BattlePlayer.tscn").instance()
	
	$Hand/hand/CardBase.player = player
	$Hand/hand/CardBase.type = "attack"
	
	get_node("Player").add_child(player)
	
	for i in range(3):
		enemies.append(load("res://dani_sandbox/scenes/battle/BattleEnemy.tscn").instance())
	for i in enemies.size():
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])
		
	$Hand/hand/CardBase2.player = enemies[0]
	$Hand/hand/CardBase2.type = "attack"
	
	$Hand/hand/CardBase.target = enemies[0]
