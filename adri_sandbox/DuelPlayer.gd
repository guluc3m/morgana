extends Node

var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
# Quizá podríamos pasar a usar getters y setters
# Estructuras
var _hand = null
var _max_hand_size = null
var _deck = null
var _graveyard = null

# Estadíscitas básicas
var _health = null
var _max_health = null
var _energy = null
var _max_energy = null

# Bonus
var _armor = null
var _damage_bonus = null

# Estados
var _burned = null



# Called when the node enters the scene tree for the first time.
func _ready():
	print("EXISTO")
	pass # Replace with function body.
	
func _init(max_hand_size, deck, health, max_health, energy, max_energy):
	self._hand = []
	self._max_hand_size = max_hand_size
	self._deck = load_deck(deck)
	self._graveyard = []

	self._health = health
	self._max_health = max_health
	self._armor = 0
	self._energy = energy
	self._max_energy = max_energy


func _process(delta):
	pass


func load_deck(card_names):
	var deck = []
	for card_name in card_names:
		deck.append(card_database[card_name].duplicate(true))
	deck.shuffle()  # La semilla es siempre la misma
	return deck
		

func modify_health(amount):
	# TODO: control de vida máxima y condición de muerte
	# TODO: control de daño pasando por armadura y resistencias
	self._health += amount

# NO PROBADA
func set_armor(amount):
	self._armor += amount


func draw_card(amount):
	for i in range(amount):
		self._hand.append(self._deck.pop_front())  # TODO: Controlar que se acaben las cartas (quizá en el getter)
	# TODO: Quizá añadir el nodo, la instancia y demás cosas visuales

# NO PROBADA
func use_card(card):
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

