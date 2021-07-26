extends Control

signal a_mazo;
var card_name;
var cards_available;


# Called when the node enters the scene tree for the first time.
func _ready():
	# self.init_image("fire")
	pass


func init_image(card_type: String):
	self.card_name = card_type
	self.cards_available = PlayerManager.card_collection[card_type]
	self.add_to_group(card_type)
	$Repeat.text = String(self.cards_available)
	$CardImage.texture = load("res://assets/sprites/cards/{}.png".format([card_type], "{}"))


func _on_CartaColeccion_gui_input(event):
	""" Evento para saber cuándo el usuario hace click o hace click derecho en la carta
	"""
	if Input.is_action_just_released("mouse_left"):
		# Idealmente aquí se pasan los argumentos necesarios para que podamos
		# identificar la carta y añadirla correctamente.
		if self.cards_available > 0:
			print("A MAZO")
			self.cards_available -= 1
			$Repeat.text = String(self.cards_available)
			emit_signal("a_mazo", self.card_name)
		
	if Input.is_action_just_released("mouse_right"):
		# TODO puede que haya que definirlo en los ajustes del proyecto
		print(event)


func increase_cards_available():
	""" Aumenta el nº de cartas disponibles después de haberlas eliminado del mazo
	"""
	self.cards_available += 1
	$Repeat.text = String(self.cards_available)
