extends "res://real_deal/scripts/duel/states/state.gd"

var damage

func _init(damage):
	self.name = "Burned"
	self.image = "TODO"
	self.type = "on_finish"; # on start, on finish, on play card, on recived card
	self.description = "Recibes pupa al final del turno";
	self.damage = damage

func get_effect():
	var amount = self.damage
	self.damage -= 1
	return [
		["base_damage", {"amount": -amount}]
	]

func has_finalized():
	return self.damage <= 0
