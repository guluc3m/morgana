extends Object

"""
Esta estructura controla los distintos stacks de cartas
(cementerio, exilio, mano y deck) para centralizar y abstraer
los eventos y funciones relacionados con el ciclo de vida de las cartas
"""

var CardsStack = preload("res://real_deal/scripts/duel/CardStack.gd")

var _hand
var _deck
var _graveyard
var _exile

# TODO: Que el max_hand_size sirva para algo

func _init(card_names):
	_hand = CardsStack.new([])
	_deck = CardsStack.new(card_names)
	_graveyard = CardsStack.new([])
	_exile = CardsStack.new([])

func draw_card():
	var card = _deck.get_next_card()
	if (card):
		_hand.add_card(card)
		return card
	return null

func can_play():
	return _hand.can_draw()

func add_temporaly_card_to_hand(card_name):
	_hand.add_temporally_card(card_name)
	

func add_temporally_card_to_deck(card_name):
	_deck.add_temporally_card(card_name)


# NO PROBADA
func suffle_deck():
	_deck.shuffle() # La semilla es siempre la misma


# NO PROBADA
# TODO: Controlar cuando la carta es eliminada por el efecto de una carta
func remove_card_from_hand(card):
	""" Elimina la carta de la mano del jugador
		y si no se exilia, la manda al cementerio
		
		@card: Diccionario de la carta en la base de datos
	"""
	var used_card = _hand.remove_card(card)
	
	if used_card:
		self.send_to_graveyard(used_card)


func send_to_graveyard(card):  # Atentos a que no la elimina de la mano o de donde sea
	""" Manda una carta al cementerio
	
		@card: Diccionario de la carta en la base de datos
	"""
	_graveyard.add_card(card)

func prepare_deck():
	if not _deck.can_draw():
		print("recargamos deck")  # quizá gestionar a nivel de diseño que siempre esté el mínimo de cartas para robar
		suffle_graveyard_into_deck()
		suffle_deck()

func suffle_graveyard_into_deck():
	var cards = _graveyard.draw_all_cards()
	_deck.add_cards(cards)


func get_deck():
	return _deck

func get_hand():
	return _hand
	
func select_random_card_from_hand():
	return _hand.get_random_card()
