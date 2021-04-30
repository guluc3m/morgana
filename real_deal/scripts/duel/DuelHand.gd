""" Escena que se encarga de la interacción con el usuario
	y la parte visual de la mano del jugador
"""
extends Control

signal removeCard
signal addCard

const CardBase = preload("res://real_deal/scenes/duel/DuelCardBase.tscn")

var _cards = []  # Esta lista es la misma referencia que la de DuelCharacter

var card_height = 48
var card_width = 40
var hand_width = 0


func _init_hand(cards=_cards):
	""" Carga las cartas para que luego en _ready se pinten en pantalla
		@param cards: Lista de cartas como DuelCardBase
	"""
	self._cards = cards
	
#	for c in self._cards:
#		add_to_hand(c)


# Called when the node enters the scene tree for the first time.
func _ready():
	""" Como se llama al instanciar, en el DuelManager se llama a este método antes
		de que se haya definido las cartas que tiene la mano. Por eso no pinta nada aquí
	"""
	self.rect_scale = Vector2(0.1, 0.1) # Esto es lo que controla como de grandes se ven las cartas
	self.hand_width = get_viewport().get_visible_rect().size.x * 0.28 / 2
	var a = get_viewport().get_visible_rect().size.x
	# $cards.set_size(Vector2(self.hand_width, self.hand_height))


func add_to_hand(card):
	""" Actualiza visualmente las cartas de la mano del jugador
	"""
	var new_card = CardBase.instance()
	new_card.card_data = card

	$cards.add_child(new_card)
	var width_cards = $cards.get_child_count() * self.card_width * new_card.current_scale.x
	var t = $cards.get_child_count() * self.card_width * new_card.current_scale.x
	var h = $cards.get_child_count()
	# var current_position = get_position()
	#set_position(Vector2(self.hand_width-width_cards, 0))
	print(new_card.rect_position)
	print(new_card.get_global_rect().position)


func _on_Hand_removeCard(card_path):
	""" Elimina la carta de la mano
	"""
	# Todo, alguna animación o algo antes de, o quizás al momento de jugarla en CardBase
	get_node(card_path).queue_free()
