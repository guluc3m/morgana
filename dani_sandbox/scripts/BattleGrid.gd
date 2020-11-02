extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = ""
var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	player = load("res://dani_sandbox/scenes/BattlePlayer.tscn").instance()
	
	$hand_location/Hand/HBoxContainer/Card.player = player
	$hand_location/Hand/HBoxContainer/Card.type = "attack"
	
	for i in range(3):
		enemies.append(load("res://dani_sandbox/scenes/BattleEnemy.tscn").instance())
	get_node("Player").add_child(player)
	for i in enemies.size():
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])
		
	$hand_location/Hand/HBoxContainer/Card2.player = enemies[0]
	$hand_location/Hand/HBoxContainer/Card2.type = "attack"
	
	$hand_location/Hand/HBoxContainer/Card.target = enemies[0]



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
