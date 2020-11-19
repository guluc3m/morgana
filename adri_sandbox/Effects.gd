extends Node


func modify_health(objetives, damage):
	for objetive in objetives:
		objetive.modify_health(damage)

func base_damage(danio):
	print("Oh, no! he recibido " + danio + " puntos de daño.")

func apply_condition(danio, condition):
	print("Oh, no! estoy " + condition + " y eso me hace " + danio + " puntos de daño.")
