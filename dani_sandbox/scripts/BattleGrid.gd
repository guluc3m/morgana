extends Node2D

var player = ""
var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_process(true)
	
	player = load("res://dani_sandbox/scenes/BattlePlayer.tscn").instance()
	
	$Hand/hand/Card.player = player
	$Hand/hand/Card.type = "attack"
	
	for i in range(3):
		enemies.append(load("res://dani_sandbox/scenes/BattleEnemy.tscn").instance())
	get_node("Player").add_child(player)
	for i in enemies.size():
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])
		
	$Hand/hand/Card2.player = enemies[0]
	$Hand/hand/Card2.type = "attack"
	
	$Hand/hand/Card.target = enemies[0]
