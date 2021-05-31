extends "res://real_deal/scripts/duel/DuelCharacter.gd"

signal card_target
signal not_card_target
signal playCard

var player = false # Comprobar si sobra
var mouse_over = false

func _ready():
	add_to_group("enemies")
	# Se añaden al grupo de "targetebles" cuando se empieza a usar una carta
	# para evitar colisiones cuando no debe
	## add_to_group("targeteable")


func _on_Battle_Enemy_Swampy_card_target():
	""" Start being a targeteable object
	"""
	get_tree().call_group("card", "get_target", self)
	#print("Enable target")


func _on_Battle_Enemy_Swampy_not_card_target():
	self.mouse_over = false
	get_tree().call_group("card", "get_target", false)
	#print("Disable target")


func select_card():
	""" En esta función reside la inteligencia de los enemigos.
	Al llamarla, estos escogen que carta quieren jugar y la retornan.
	"""
	if self._hand:
		print(self.name, " va a jugar: ", _hand[0]["name"])
		return self._hand[0]
	return false
