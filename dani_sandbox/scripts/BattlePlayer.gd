extends "res://dani_sandbox/scripts/BattleCharacter.gd"

signal playerAttack

func _ready():
	play_idle()


func _process(delta):
	pass


func _on_Character_animation_finished():
	if $Character.animation == "attack":
		play_idle()


func play_idle():
	$Character.animation = "idle"
	$Character.play()


func _on_Battle_Player_playerAttack():
	$Weapon/AnimationPlayer.play("attack")
