extends Node


func modify_health(objetives, damage):
	for objetive in objetives:
		objetive.modify_health(damage)
