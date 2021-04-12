extends Node

func _ready():
	pass

const DATA = {
	"normal_slime": {
		"class": "slime",
		"type": "ordinary",
		"level": 1,
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
		"class": "slime",
		"type": "ordinary",
		"level": 2,
		"deck": [
			
		],
		"strategy": "basic",
		"skills": [],
		"loot": []
	}
}
