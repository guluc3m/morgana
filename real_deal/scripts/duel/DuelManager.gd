extends Node2D


var player = ""
var enemies = []

# TESTING VARS
onready var _player_instance = preload("res://real_deal/scenes/duel/DuelPlayer.tscn")
const _enemies_scenes = [
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn"),
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn")
]
	
	
var test_deck = ["sword", "potion", "fire"]
var test_deck2 = ["sword", "fire"]


func _init_entities(player_instance, _enemies_scenes):
	player = player_instance.instance()
	player._init_params(self.test_deck)
	get_node("Player").add_child(player)

	for i in _enemies_scenes.size():
		var enemy = _enemies_scenes[i].instance()
		enemy._init_params(self.test_deck2)
		enemies.append(enemy)
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])
		
	$Hand._init_hand(player._hand)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	_init_entities(self._player_instance, self._enemies_scenes)
	#set_process(true)

func basura():
	pass
	# var new_card = CardBase.instance()
	# new_card.card_data = card_database[Compendium[randi() % 3]]
	# $Cards.add_child(new_card)
