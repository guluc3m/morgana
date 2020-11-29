extends "res://dani_sandbox/scripts/BattleCharacter.gd"

signal playerAttack

var target

func _ready():
	add_to_group("player")

func _on_Battle_Player_playerAttack():
	$Weapon/AnimationPlayer.play("attack")
	var bleed = load("res://dani_sandbox/scenes/bleed.tscn").instance()
	bleed.set_emitting(true)
	target.add_child(bleed)
	
