extends "res://real_deal/scripts/duel/DuelCharacter.gd"

signal playerAttack

var player = true
var target


func _ready():
	add_to_group("real_player")
	

func play_animation(anim):
	pass


func _on_Battle_Player_playerAttack():
	var bleed = load("res://real_deal/scenes/duel/effects/bleed.tscn").instance()
	bleed.set_emitting(true)
	target.add_child(bleed)
