const DATA = {
	"placeholder": {
		"name": "placeholder",
		"type": "placeholder",
		"cost": 7,
		"dexterity": 7,
		"description": "Yo... \n Existo.\n No me pidas más",
		"actions": []
	},
	"sword": {
		"name": "Sword",
		"type": "attack",
		"cost": 1,
		"dexterity": 3,
		"description": "Úsame... \n ¡y mata!",
		"exiled": false,
		"actions": [
			["base_damage", {"amount": 1}],
		],
	},
	"potion": {
		"name": "Potion",
		"type": "magic",
		"cost": 2,
		"dexterity": 2,
		"description": "Yo curo :)",
		"exiled": false,
		"actions": [
			["apply_condition", {"amount": -4, "condition": "curandome"}],
		],
	},
	"fire": {
		"name": "Fire",
		"type": "magic",
		"cost": 7,
		"dexterity": 7,
		"description": "Bwahaha ha ha",
		"exiled": true,
		"actions": [
			["base_damage", {"amount": 1}],
			["apply_condition", {"amount": 5, "condition": "ardiendo"}],
		],
	},
}
