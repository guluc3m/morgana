extends "res://dani_sandbox/scripts/BattleCharacter.gd"

signal card_target

var mouse_over = false

func _ready():
	add_to_group("enemies")
	add_to_group("targeteable")


func _on_Battle_Enemy_Swampy_card_target():
	""" Start being a targeteable object
	"""
	if mouse_over:
		print("Enable target")
	else:
		print("Disable target")
