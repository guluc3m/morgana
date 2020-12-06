extends Node


# Definir un diccionario como argumento para evitar tener que repetir el for y
# otras cosas en todas las funciones
#func apply(objectives, func_name, **kwargs):
#	func_name(objectives, kwargs)
	

func modify_health(kwargs):
	for objetive in kwargs["objetives"]:
		objetive.modify_health(kwargs["amount"])


func damage(objectives, damage):
	print("Oh, no! he recibido " + damage + " puntos de daño.")


func apply_condition(objectives, damage, condition):
	print("Oh, no! estoy " + condition + " y eso me hace " + damage + " puntos de daño.")


func set_armor(kwargs):
	for objetive in kwargs["objetives"]:
		objetive.set_armor(kwargs["amount"])


func draw_card(kwargs):
	for objetive in kwargs["objetives"]:
		objetive.draw_card(kwargs["amount"])


func exile_card(card):
	# Será usada si hay cartas que tengan el poder de exiliar otras cartas
	pass


func destroy_card(kwargs):
	kwargs["owner"].send_to_graveyard(kwargs["card"])


func increase_damage(objetives, amount):
	pass


func add_temporally_card(kwargs):
	#Hacer versión exiliada de la carta
	for objetive in kwargs["objetives"]:
		objetive.add_card(kwargs["card_name"])


func suffle_deck(kwargs):
	for objetive in kwargs["objetives"]:
		objetive.suffle_deck()


func set_energy(kwargs):
	for objetive in kwargs["objetives"]:
		objetive.set_energy(kwargs["amount"])


# TODO: Las cartas de daño pueden tener un atributo de tipo de daño
# (fuego/cortante/verdadero... y hay que gestionar eso cuando se juegan
	
