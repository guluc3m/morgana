extends Area2D

# TODO: Meter esta variable en autoload
var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
var floating_text = preload("res://real_deal/scenes/utils/FloatingText.tscn")
# Quizá podríamos pasar a usar getters y setters
# Estructuras
var _hand = null
var _deck = null
var _graveyard = null
export var _max_hand_size = 5
export var _draw_amount = 3

# Estadíscitas básicas
export var _health = 10
export var _max_health = 10
export var _energy = 0
export var _max_energy = 100

# Bonus
var _armor = null
var _damage_bonus = null

# Estados
var is_alive = true
var _burned = null


func draw_text(draw, color=[0,0,0]):
	""" Draw the text over the character sprite
	"""
	var text = floating_text.instance()
	text.text = draw
	text.color = color
	add_child(text)


# Called when the node enters the scene tree for the first time.
func _ready():
	play_animation("idle")
	
	
func _init_params(deck, hand_node, max_hand_size=_max_hand_size, health=_health,
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
	
	draw_card(self._draw_amount, hand_node)


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
	
	# Aquí se dibuja el daño, rojo si es daño, verde si es positivo
	if amount >= 0:
		self.draw_text(amount, [0,255,0])
	else:
		self.draw_text(abs(amount), [255,0,0])
	
	self._health += amount
	if self._health <= 0:
		self.is_alive = false
		play_animation("dead")
		

# NO PROBADA
func set_armor(amount):
	# Aquí se dibuja la armadura obtenida en color amarillo-marrón
	self.draw_text(abs(amount), [226,185,0])
	self._armor += amount


func draw_card(amount, hand_node):
	if amount > self._deck.size():
		amount = self._deck.size()
	for i in range(amount):
		var card = self._deck.pop_front()
		self._hand.append(card)
		if hand_node: # Los enemigos no tienen
			hand_node.add_to_hand(card)
		
	# TODO: Controlar que se acaben las cartas (quizá en el getter)
	# llamar a reshuffle() ???
	# TODO: Quizá añadir el nodo, la instancia y demás cosas visuales

func start_turn(hand_node):
	# Aquí va restauración de energía, cooldown de contadores y efectos al empezar el turno
	if not self._deck:
		print("recargamos deck")  # quizá gestionar a nivel de diseño que siempre esté el mínimo de cartas para robar
		for card in self._graveyard:
			self._deck.append(card)
		suffle_deck()
	self._update_state()
	self.draw_card(min(self._max_hand_size - len(self._hand), self._draw_amount), hand_node)

func _update_state():
	print(self.name, " recupera energía y avanzan los contadores")


# NO PROBADA
# TODO: Controlar cuando la carta es eliminada por el efecto de una carta
func remove_card(card):
	""" Elimina la carta de la mano del jugador
		y si no se exilia, la manda al cementerio
		
		@card: Diccionario de la carta en la base de datos
	"""
	self._hand.remove(self._hand.find(card))  # No he encontrado la función para eliminar un objeto de la lista
	
	if not card["exiled"]:
		self.send_to_graveyard(card)


func send_to_graveyard(card):  # Atentos a que no la elimina de la mano o de donde sea
	""" Manda una carta al cementerio
	
		@card: Diccionario de la carta en la base de datos
	"""
	self._graveyard.append(card)


# NO PROBADA
func increase_damage(amount):
	self._bonus += amount


func add_temporaly_card_to_hand(card_name):
	# Hacer versión exiliada de la carta
	var card = card_database[card_name].duplicate(true)
	card["exiled"] = true
	self._hand.append(card)


func add_temporally_card_to_deck(card_name):
	# Hacer versión exiliada de la carta
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
		play_animation("idle")


func play_animation(animation):
	""" Play the animation specified by parameter
	"""
	$Character.animation = animation
	$Character.play()
