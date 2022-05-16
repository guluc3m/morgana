extends Object

"""
Esta clase es una pila de cartas, generalmente funciona casi igual que una lista
pero la idea es que se encarge de lanzar eventos además del comportamiento propio
de una lista. Quizá para que esto tenga sentido sería necesario hacer clases hijas
y que cada una lance los eventos del tipo que corresponde o que en la inicialización
se pueda determinar el parámetro de tipo con un diccionario de eventos.
"""

# TODO: Meter esta variable en autoload
var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA

var _cards = []

func size():
	return _cards.size()
	
func get_cards():
	return _cards

func _init(card_names):
	for card_name in card_names:
		_cards.append(card_database[card_name].duplicate(true))

func can_draw():
	return not _cards.empty()
	
func add_card(card):
	_cards.append(card)

func draw_all_cards():
	var cards = _cards.duplicate()
	_cards.clear()
	return cards
	
func add_cards(cards):
	_cards += cards

func get_next_card():
	if can_draw():
		return _cards.pop_front()
	# TODO: Controlar que se acaben las cartas (quizá en el getter)
	# llamar a reshuffle() ???
	# TODO: Quizá añadir el nodo, la instancia y demás cosas visuales
# NO PROBADA
# TODO: Controlar cuando la carta es eliminada por el efecto de una carta

func get_random_card():
	#return _cards.pop_at(rand_range(0, _cards.size() -1)) Dice que no existe a pesar de que aparece en la documentación
	return _cards.pop_front()

func get_concrete_card(card):
	_cards.remove(card)
	return card

func remove_card(card):
	""" Elimina la carta de la pila y la retorna si no es exiliada
		
		@card: Diccionario de la carta en la base de datos
	"""
	_cards.remove(_cards.find(card))  # No he encontrado la función para eliminar un objeto de la lista
	
	if not card["exiled"]:
		return card


func add_temporally_card(card_name):
	""" Hacer versión exiliada de la carta
	
		@card: nombre de la carta en la base de datos
	"""
	var card = card_database[card_name].duplicate(true)
	card["exiled"] = true
	_cards.add_card(card)

func shuffle(): # La semilla es siempre la misma
	_cards.shuffle()
