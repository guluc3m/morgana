extends Control

signal playerAttack

var player = ""
var target = ""
var type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	player.get_node("Character").animation = type
	if target:
		player.target = target
	player.emit_signal("playerAttack")
	player.get_node("Character").play()
