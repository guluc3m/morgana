extends Node2D

signal playCard

onready var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

var player = ""
var enemies = []
var current_turn = "" # Id del nodo
var turn_sequence = []  # TODO: Trnasformar en estructura de cola
var turn_sequence_index = 0

var scene_to_return = "res://real_deal/scenes/map/mvp_nivel1.tscn"
var scene_main_menu = "res://real_deal/scenes/menu/MainMenu.tscn"

# TESTING VARS
onready var _player_instance = preload("res://real_deal/scenes/duel/DuelPlayer.tscn")
const _enemies_scenes = [
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn"),
	preload("res://real_deal/scenes/duel/DuelEnemy.tscn")
]

var test_deck = ["sword", "potion", "fire", "sword", "potion", "fire", "sword", "potion", "fire", "sword", "potion", "fire"]
var test_deck2 = ["sword", "sword", "sword", "sword", "sword"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass#_init_entities(self._player_instance, self._enemies_scenes)  # Esto lo tiene que llamar el scene manager
	#set_process(true)
	
	
func _process(delta):
	# HABRÍA QUE REVISAR ESTO PORQUE ES UN POCO PEGOTE
	if self.current_turn == player:
		if self.current_turn.is_alive:
			if _are_enemies_dead():
				_player_win_duel()
				return
			else:
				return
		else:
			_player_lose_duel()
			return
	# Enemy turn 
	if self.current_turn.is_alive:
		var card_to_play = self.current_turn.select_card()
		while card_to_play:
			self._on_Main_playCard(
				null,
				card_to_play,
				player
			)
			card_to_play = self.current_turn.select_card()
	self._on_finish_turn()
	

func _init_entities(enemy_datas):
	# Init player
	player = _player_instance.instance()
	player._init_params(  # Quizá cambiar esto para pasar directamente un diccionario y que la clase se gestione
		PlayerManager.deck,
		$Hand,
		PlayerManager.max_hand_size,
		PlayerManager.health,
		PlayerManager.max_health,
		PlayerManager.energy,
		PlayerManager.max_energy
	)
	get_node("Player").add_child(player)
	
	# TESTING quizás luego es random o algo, yuqse
	self.turn_sequence.append(player)
	self.current_turn = player

	# Init enemies
	for enemy_data in enemy_datas:
		var enemy = enemy_data["scene"].instance()
		enemy._init_params(#[], null)
			enemy_data["deck"],
			null,
			enemy_data["max_hand_size"],
			enemy_data["max_health"],
			enemy_data["max_health"],
			enemy_data["max_energy"],
			enemy_data["max_energy"]
		)
		self.enemies.append(enemy)
		self.turn_sequence.append(enemy)
		get_node("Enemy_{i}".format({'i':enemies.size() - 1})).add_child(enemies[enemies.size() - 1])
		
	$Hand._init_hand(player._hand)


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
	if self.current_turn.player:
		$Hand.emit_signal("removeCard", card_path)
	# Elimina la carta de la estructura de la mano
	self.current_turn.remove_card(card_data)
	
	
func _on_finish_turn():
	# TODO: efectos de finalizar el turno
	self.turn_sequence_index = (self.turn_sequence_index + 1) % self.turn_sequence.size()
	self.current_turn = self.turn_sequence[self.turn_sequence_index]
	_on_start_turn(self.current_turn)


func _on_start_turn(character_node):
	if self.turn_sequence_index == 0:
		character_node.start_turn($Hand)
	character_node.start_turn(null)


func _on_Button_pressed():
	self._on_finish_turn()


func _input(event):
	if Input.is_action_pressed("ui_right"):
		SceneManager.goto_scene(scene_to_return, null)
		
		
func _player_lose_duel():
	print("has pedido")
	SceneManager.goto_scene("res://real_deal/scenes/menu//MainMenu.tscn", null)


func _player_win_duel():
	print("has ganado")
	PlayerManager.health = self.player._health # TODO: Cambiar acceso a estas variables
	PlayerManager.energy = self.player._energy
	PlayerManager.save()
	SceneManager.goto_scene(scene_to_return, {
		"enemy_defeat": true  #TODO Lista con el path del nodo que no hay que cargar
	})
	

func _are_enemies_dead():
	for enemy in self.enemies:
		if enemy.is_alive:
			return false
	return true


func update_data(data):
	var enemies_data = []
	for enemy_name in data['enemigos']:
		enemies_data.append(EnemiesDatabase.DATA[enemy_name])
	_init_entities(enemies_data)  # Esto quiza lo tiene que llamar el scene manager (aunque indirectamente lo hace)
