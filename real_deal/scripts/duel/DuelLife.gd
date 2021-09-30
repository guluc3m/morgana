""" Objeto para representar la vida del jugador y poder interaccionar
	con ella como si fuese un elemento más de la escena.
"""
extends Area2D
#extends MarginContainer
# extends "res://real_deal/scripts/duel/DuelCharacter.gd"

signal card_target
signal not_card_target

var mouse_over = false
var real_player


func _ready():
	add_to_group("player")


func _on_Area2D_card_target():
	""" Redirige acciones a la entidad del jugador
	"""
	if not self.real_player:
		self.real_player = get_tree().get_nodes_in_group("real_player")[0]
	get_tree().call_group("card", "get_target", real_player)


func _on_Area2D_not_card_target():
	""" Desapunta
	"""
	self.mouse_over = false
	get_tree().call_group("card", "get_target", false)
	#print("Disable target")
