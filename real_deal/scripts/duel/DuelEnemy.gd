extends "res://real_deal/scripts/duel/DuelCharacter.gd"

signal card_target
signal not_card_target

var player = false
var mouse_over = false

func _ready():
	add_to_group("enemies")
	# Se añaden al grupo de "targetebles" cuando se empieza a usar una carta
	# para evitar colisiones cuando no debe
	## add_to_group("targeteable")


func _on_Battle_Enemy_Swampy_card_target():
	""" Start being a targeteable object
	"""
	print("Enable target")


func _on_Battle_Enemy_Swampy_not_card_target():
	self.mouse_over = false
	print("Disable target")
