extends Control

var card_database = load("res://real_deal/scripts/utils/CardsDatabase.gd").DATA

signal a_coleccion;
var card_name;


# Called when the node enters the scene tree for the first time.
func _ready():
	# self.init_image("fire")
	pass # Replace with function body.


func init_image(card_type: String):
	self.card_name = card_type
	$Nombre.text = String(card_database[card_type]["name"])
	$Valor.text = String(card_database[card_type]["cost"])
	# $CardImage.texture = load("res://assets/sprites/cards/{}.png".format([card_type], "{}"))


func _on_CartaMazo_gui_input(_event):
	""" Evento para saber cuándo el usuario hace click y así eliminarla (visualmente)
		del mazo.
	"""
	if Input.is_action_just_released("mouse_left"):
		print("A colleccion")
		get_tree().call_group(self.card_name, "increase_cards_available")
		queue_free();
		
