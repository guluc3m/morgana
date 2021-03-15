extends Node2D

signal playCard

onready var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

var player = ""
var enemies = []
var turn = "" # Id del nodo

var scene_to_return = "res://real_deal/scenes/exploration/levels/LevelTemplate.tscn"

# TESTING VARS
onready var _player_instance = preload("res://real_deal/scenes/duel/DuelPlayer.tscn")
const _enemies_scenes = [
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn"),
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn")
]

var test_deck = ["sword", "potion", "fire", "sword", "potion", "fire", "sword", "potion", "fire", "sword", "potion", "fire"]
var test_deck2 = ["sword", "fire"]


func _init_entities(player_instance, _enemies_scenes):
	player = player_instance.instance()
	player._init_params(self.test_deck, $Hand)
	get_node("Player").add_child(player)
	
	# TESTING quizás luego es random o algo, yuqse
	self.turn = player

	for i in _enemies_scenes.size():
		var enemy = _enemies_scenes[i].instance()
		enemy._init_params([], null)
		enemies.append(enemy)
		get_node("Enemy_{i}".format({'i':i})).add_child(enemies[i])
		
	$Hand._init_hand(player._hand)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	_init_entities(self._player_instance, self._enemies_scenes)
	#set_process(true)


func _on_Main_playCard(card_path, card_data, target):
	""" Ejecuta las acciones de la carta
	"""
	for f in card_data['actions']:
		var func_name = f[0]
		var args = f[1]
		args['objectives'] = [target]
		card_functions.card_func(func_name, args)
#		var funcion = funcref(card_functions, f[0])
#		funcion.call_funcv(f[1])

	# Elimina la carta de la mano visible
	if self.turn.player:
		$Hand.emit_signal("removeCard", card_path)
	# Elimina la carta de la estructura de la mano
	self.turn.remove_card(card_data)
	
	
func _on_start_turn(character_node):
	character_node.start_turn($Hand)
	

func _on_Button_pressed():
	print(len(player._hand), " ", len(player._deck), " ", len(player._graveyard))
	_on_start_turn(player)
	print(len(player._hand), " ", len(player._deck), " ", len(player._graveyard))


func _input(event):
	if Input.is_action_pressed("ui_right"):
		SceneManager.goto_scene(scene_to_return)
