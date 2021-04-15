extends Node

func _ready():
	pass

const DATA = {
	"normal_slime": {
		"name": "Slime",
		"scene": preload("res://real_deal/scenes/duel/DuelEnemy.tscn"),
		"class": "slime",
		"type": "ordinary",
		"level": 1, # Algunas cosas podrías ser calculadas con funciones en el futuro
		"max_hand_size": 3,
		"draw_amount": 2,
		"max_health": 5,
		"max_energy": 0,
		"deck": [
			"super_thump",
			"super_thump",
			"thump",
			"thump",
			"thump",
			"thump",
			"thump",
			"thump",
		],
		"strategy": "basic",
		"skills": [],
		"loot": [
			["Slime remains", 1.0], # Object and probability
			["Slime remains", 0.3]
		]
	},
	"fire_slime": {
		"name": "Fire Slime",
		"scene": preload("res://real_deal/scenes/duel/DuelEnemy.tscn"),
		"class": "slime",
		"type": "ordinary",
		"level": 2, # Algunas cosas podrías ser calculadas con funciones en el futuro
		"max_hand_size": 5,
		"draw_amount": 3,
		"max_health": 10,
		"max_energy": 0,
		"deck": [
			
		],
		"strategy": "basic",
		"skills": [],
		"loot": []
	}
}
