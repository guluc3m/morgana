const DATA = {
	"placeholder": {
		"name": "",
		"image": "same as key",
		"type": "",
		"description": "",
		"effects": "",
		"add_card": true,
		"card_name": "",
		"actions": [],
	},
	"berry": {
		"name": "Baya",
		"image": "berry",
		"type": "object",
		"description": "Una baya que parece venenosa... Bueno soy un fantasma, seguro que no me mata",
		"effects": "Cura 5 puntos de vida",
		"add_card": false,
		"card_name": "",
		"actions": [
			["health", +5],
		],
	},
	"helmet": {
		"name": "Casco",
		"image": "helmet",
		"type": "equipment",
		"description": "Un casco de hierro",
		"effects": "Te otorga la carta thump",
		"add_card": true,
		"card_name": "thump",
		"actions": [],
	},
	"slime_remains": {
		"name": "Restos de slime",
		"image": "slime_remains",
		"type": "object",
		"description": "Restos de un slime",
		"effects": "",
		"add_card": false,
		"card_name": "",
		"actions": [],
	}
}
