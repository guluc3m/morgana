extends Area2D

var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
# Quizá podríamos pasar a usar getters y setters
# Estructuras
var _hand = null
var _deck = null
var _graveyard = null
export var _max_hand_size = 5

# Estadíscitas básicas
export var _health = 100
export var _max_health = 100
export var _energy = 0
export var _max_energy = 100

# Bonus
var _armor = null
var _damage_bonus = null

# Estados
var _burned = null


# Called when the node enters the scene tree for the first time.
func _ready():
	play_idle()
	
	
func _init_params(deck, max_hand_size=_max_hand_size, health=_health,
		   max_health=_max_health, energy=_energy, max_energy=_max_energy):
	""" Inicializa valores base para todos los personajes
	"""
	self._hand = []
	self._max_hand_size = max_hand_size
	self._deck = load_deck(deck)
	self._graveyard = []

	self._health = health
	self._max_health = max_health
	self._armor = 0
	self._energy = energy
	self._max_energy = max_energy
	
	draw_card(self._max_hand_size)


func _process(delta):
	pass


func load_deck(card_names):
	""" Carga los datos correspondientes para cada carga en el deck
	"""
	var deck = []
	for card_name in card_names:
		deck.append(card_database[card_name].duplicate(true))
	deck.shuffle()  # La semilla es siempre la misma
	return deck
		

func modify_health(amount):
	# TODO: control de vida máxima y condición de muerte
	# TODO: control de daño pasando por armadura y resistencias
	print("He colega, que me curo ", amount)
	self._health += amount


# NO PROBADA
func set_armor(amount):
	self._armor += amount


func draw_card(amount):
	if amount > self._deck.size():
		amount = self._deck.size()
	for i in range(amount):
		self._hand.append(self._deck.pop_front())
		
	# TODO: Controlar que se acaben las cartas (quizá en el getter)
	# llamar a reshuffle() ???
	# TODO: Quizá añadir el nodo, la instancia y demás cosas visuales


# NO PROBADA
func use_card(card):
	print("Usando ", card)
	self._hand.remove(self._hand.find(card))  # No he encontrado la función para eliminar un objeto de la lista


func send_to_graveyard(card):  # Atentos a que no la elimina de la mano o de donde sea
	self._graveyard.append(card)


# NO PROBADA
func increase_damage(amount):
	self._bonus += amount


func add_temporally_card_to_hand(card_name):
	#Hacer versión exiliada de la carta
	var card = card_database[card_name].duplicate(true)
	card["exiled"] = true
	self._hand.append(card)


func add_temporally_card_to_deck(card_name):
	#Hacer versión exiliada de la carta
	var card = card_database[card_name].duplicate(true)
	card["exiled"] = true
	self._deck.append(card)


# NO PROBADA
func suffle_deck():
	self._deck.shuffle() # La semilla es siempre la misma


# NO PROBADA
func set_energy(amount):
	self.energy += amount  # TODO: Control de máximo y mínimo


func get_deck():
	return self._deck


func get_hand():
	return self._hand


func _on_Character_animation_finished():
	if $Character.animation == "attack":
		play_idle()


func play_idle():
	$Character.animation = "idle"
	$Character.play()
