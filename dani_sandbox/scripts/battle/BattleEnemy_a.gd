extends "res://dani_sandbox/scripts/battle/BattleCharacter_a.gd"

signal card_target

var mouse_over = false

func _ready():
	add_to_group("enemies")
	# Se añaden al grupo de "targetebles" cuando se empieza a usar una carta
	# para evitar colisiones cuando no debe
	## add_to_group("targeteable")


func _on_Battle_Enemy_Swampy_card_target():
	""" Start being a targeteable object
	"""
	if mouse_over:
		print("Enable target")
	else:
		print("Disable target")
