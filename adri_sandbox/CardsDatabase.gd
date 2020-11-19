const DATA = {
	"Placeholder": {
		"type": "placeholder",
		"cost": 7,
		"dexterity": 7,
		"description": "Yo... \n Existo.\n No me pidas más",
	},
	"Sword": {
		"type": "attack",
		"cost": 1,
		"dexterity": 3,
		"description": "Úsame... \n ¡y mata!",
		"actions": [
			["base_damage", ["124"]],
		],
	},
	"Potion": {
		"type": "magic",
		"cost": 2,
		"dexterity": 2,
		"description": "Yo curo :)",
		"actions": [
			["apply_condition", ["-4", "curandome"]],
		],
	},
	"Fire": {
		"type": "condition",
		"cost": 7,
		"dexterity": 7,
		"description": "Ja ja ja ja",
		"actions": [
			["base_damage", ["1"]],
			["apply_condition", ["5", "ardiendo"]],
		],
	},
}
