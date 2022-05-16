extends Area2D

var DuelCharacterCardsHandler = preload("res://real_deal/scripts/duel/DuelCharacterCardsHandler.gd")
onready var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

# Quizá podríamos pasar a usar getters y setters
# Estructuras
var deck_handler = null
export var _max_hand_size = 5
export var _draw_amount = 3
var _healthBar

# Estadíscitas básicas
export var _health = 10
export var _max_health = 10
export var _energy = 0
export var _max_energy = 100

# Bonus
var _armor = null
var _damage_bonus = null

# Estados
var _states = {
	"on_start": [],
	"on_finish": [],
	"on_play_card": [],
	"on_recived_card": []
	}
var _ui_states

func is_alive():
	return _health > 0



# Called when the node enters the scene tree for the first time.
func _ready():
	play_animation("idle")
	

func _init_params(deck, is_player, max_hand_size=_max_hand_size, health=_health,
		   max_health=_max_health, energy=_energy, max_energy=_max_energy):
	""" Inicializa valores base para todos los personajes
	"""
	self._max_hand_size = max_hand_size
	self.deck_handler = DuelCharacterCardsHandler.new(deck)

	self._health = health
	self._max_health = max_health
	self._armor = 0
	self._energy = energy
	self._max_energy = max_energy
	
	draw_card(self._draw_amount, is_player)


func modify_health(amount):
	# TODO: control de daño pasando por armadura y resistencias
	_health = min(amount + _health, _max_health)
	if not is_alive():
		_dead()
	
func _dead():
	play_animation("dead")
	
# ESTATES
func add_state(state):
	_states[state.type].append((state))
	# TODO: EVENTOS Y COSAS PARA ACTUALIZAR UI O LO QUE SURJA

func process_states(state_type):
	for state in _states[state_type]:
		for effect in state.get_effect():
			var func_name = effect[0]
			var args = effect[1]
			args['objectives'] = [self]
			card_functions.card_func(func_name, args)

# NO PROBADA
func set_armor(amount):
	self._armor += amount


func draw_card(amount, is_player):
	if amount > deck_handler._deck.size():
		amount = deck_handler._deck.size()
	for i in range(amount):
		var card = deck_handler.draw_card()
		if is_player: # Los enemigos no tienen
			get_tree().current_scene.emit_signal(
				"addCard", card
			)
		
	# TODO: Controlar que se acaben las cartas (quizá en el getter)
	# llamar a reshuffle() ???
	# TODO: Quizá añadir el nodo, la instancia y demás cosas visuales


func remove_card(card_data):
	deck_handler.remove_card_from_hand(card_data)
	
func start_turn(is_player):
	# Aquí va restauración de energía, cooldown de contadores y efectos al empezar el turno
	deck_handler.prepare_deck()
	self._update_state()
	self.draw_card(self._draw_amount, is_player)


func _update_state():
	print(self.name, " recupera energía y avanzan los contadores")



# NO PROBADA
func increase_damage(amount):
	self._bonus += amount



# NO PROBADA
func set_energy(amount):
	self.energy += amount  # TODO: Control de máximo y mínimo




func _on_Character_animation_finished():
	if $Character.animation == "attack":
		play_animation("idle")


func play_animation(animation):
	""" Play the animation specified by parameter
	"""
	$Character.animation = animation
	$Character.play()
