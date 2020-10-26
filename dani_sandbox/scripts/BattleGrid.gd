extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = ""
var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	player = load("res://dani_sandbox/scenes/BattlePlayer.tscn").instance()
	for i in range(3):
		enemies.append(load("res://dani_sandbox/scenes/BattleEnemy.tscn").instance())
	get_node("Player").add_child(player)
	for i in enemies.size():
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
