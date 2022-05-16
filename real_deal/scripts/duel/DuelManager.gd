extends Control

signal playCard
signal removeCard
signal addCard

const CardBase = preload("res://real_deal/scenes/duel/DuelCardBase.tscn")
onready var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()
onready var _player_instance = preload("res://real_deal/scenes/duel/DuelPlayer.tscn")

var player = ""
var mano = null
var enemies = []
var current_turn = "" # Id del nodo
var turn_sequence = []  # TODO: Trnasformar en estructura de cola
var turn_sequence_index = 0
var poscombat = {}  # En caso de que tras el combate haya que hacer algo
var scene_main_menu = "res://real_deal/scenes/menu/MainMenu.tscn"

###### Variables para la mano
# Referencia: https://www.youtube.com/watch?v=gUNhn5BJlJ0
onready var hand_center = get_viewport().get_visible_rect().size * Vector2(0.5, 1.2)
onready var h_rad = get_viewport().get_visible_rect().size.x * 0.45
onready var v_rad = get_viewport().get_visible_rect().size.y * 0.4

var card_size = Vector2(200/2, 275/2)
var angle = deg2rad(90) - 0.5
var OvalAngleVector = Vector2()
#################


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	get_node("Player").add_child(player)
	# Quizá cambiar esto para pasar directamente un diccionario y que la clase se gestione
	player._init_params(
		PlayerManager.deck,
		true,
		PlayerManager.max_hand_size,
		PlayerManager.health,
		PlayerManager.max_health,
		PlayerManager.energy,
		PlayerManager.max_energy
	)
	
	# Conectamos la barra de vida y la inicializamos. Esto habría que sacarlo a una clase propia y refactorizarlo un rato
	player._healthBar = $UI_Elements_left/BarConatiner/ProgressBar
	player._healthBar.max_value = player._max_health
	player._healthBar.value = player._health
	# TESTING quizás luego es random o algo, yuqse
	self.turn_sequence.append(player)
	self.current_turn = player

	# Init enemies
	for enemy_data in enemy_datas:
		var enemy = enemy_data["scene"].instance()
		self.enemies.append(enemy)
		self.turn_sequence.append(enemy)
		get_node("Enemigos/Enemy_{i}".format({'i':enemies.size() - 1})).add_child(enemies[enemies.size() - 1])
		enemy.set_data(enemy_data)


func add_to_hand(card):
	""" Actualiza visualmente las cartas de la mano del jugador
	"""
	var new_card = CardBase.instance()
	new_card.card_data = card
	
	self.place_card(new_card)
	
	$Hand.add_child(new_card)


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
		self.remove_card(card_path)

	# Elimina la carta de la estructura de la mano
	self.current_turn.remove_card(card_data)
	
	
func remove_card(card_path):
	""" Elimina la carta de la mano
	"""
	# TODO, alguna animación o algo antes de, o quizás al momento de jugarla en CardBase
	get_node(card_path).queue_free()


func place_card(card):
	""" Reordena las cartas de la mano para que no haya espacios en vacíos
	"""
	self.OvalAngleVector = Vector2(self.h_rad * cos(self.angle), -self.v_rad * sin(self.angle))
	
	card.rect_position = self.hand_center + self.OvalAngleVector - card.rect_size * Vector2(0.25, 0.5)
	#card.rect_scale = self.card_size/card.rect_size
	card.rect_rotation = (90 - rad2deg(self.angle))/4

	self.angle += 0.25


func _on_finish_turn():
	# TODO: efectos de finalizar el turno
	self.turn_sequence_index = (self.turn_sequence_index + 1) % self.turn_sequence.size()
	self.current_turn = self.turn_sequence[self.turn_sequence_index]
	_on_start_turn(self.current_turn)


func _on_start_turn(character_node):
	if self.turn_sequence_index == 0:
		# Reordena las cartas de la mano
		self.angle = deg2rad(90) - 0.5
		for card in $Hand.get_children():
			self.place_card(card)
		character_node.start_turn(true)
	character_node.start_turn(null)


func _on_Button_pressed():
	self._on_finish_turn()


func _input(event):
	pass
	# if Input.is_action_pressed("ui_right"):
	# 	SceneManager.goto_scene(scene_to_return, null)
		
		
func _player_lose_duel():
	print("has pedido")
	SceneManager.goto_scene("res://real_deal/scenes/map/mvp_limbo.tscn", {"escena": "mvp_limbo"})


func _player_win_duel():
	print("has ganado")
	var reward = _get_reward()
	PlayerManager.add_reward(reward)
	PlayerManager.health = self.player._health # TODO: Cambiar acceso a estas variables
	PlayerManager.energy = self.player._energy
	PlayerManager.save()
	SceneManager.goto_scene(SceneManager.previous_scene, {"env": self.poscombat})


func _are_enemies_dead():
	for enemy in self.enemies:
		if enemy.is_alive:
			return false
	return true


func _get_reward():
	"""
	Al terminar el duelo se obtienen las posibles recompensas de los enemigos
	y cargan en un diccionario que será incluido en el inventario del jugador.
	Ese diccionario también se pasará al cambiar de escenar para mostrar las
	recompensas obtenidas.
	"""
	var reward = []
	for enemy in self.enemies:
		for item in enemy.loot:
			reward.append(item)
	print(reward)
	return reward


func update_data(data):
	var enemies_data = []
	var enemy_name = ""
	for enemy in data['enemigos']:
		enemy_name = enemy.split("-")[0]
		enemies_data.append(EnemiesDatabase.DATA[enemy_name])
	_init_entities(enemies_data)  # Esto quiza lo tiene que llamar el scene manager (aunque indirectamente lo hace)
	if "env" in data:
		self.poscombat = data['env']


func _on_Main_addCard(card):
	""" Llama a la función para añadir carta a la mano
		Esto es simplemente un alias para poder llamarlo desde
		otras escenas
	"""
	self.add_to_hand(card)


func _on_Main_removeCard(card_path):
	""" Llama a la función para eliminar una carta de la mano
		Esto es simplemente un alias para poder llamarlo desde
		otras escenas
	"""
	self.remove_card(card_path)
