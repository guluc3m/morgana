extends Node


# Definir un diccionario como argumento para evitar tener que repetir el for y
# otras cosas en todas las funciones
#func apply(objectives, func_name, **kwargs):
#	func_name(objectives, kwargs)

func card_func(func_name, kwargs={}):
	var objectives = kwargs.get("objectives", [])
	for objective in objectives:
		var function = funcref(self, func_name)
		function.call_func(objective, kwargs)
		

func base_damage(objective, kwargs):
	objective.modify_health(kwargs["amount"])


func apply_condition(objective, kwargs):
	print("Oh, no! estoy ", kwargs["condition"], " y eso me hace ", kwargs["amount"], " puntos de daño.")


func set_armor(objective, kwargs):
	objective.set_armor(kwargs["amount"])


func draw_card(objective, kwargs):
	objective.draw_card(kwargs["amount"])


func exile_card(objective, kwargs):
	# Será usada si hay cartas que tengan el poder de exiliar otras cartas
	objective.exile()


func destroy_card(objective, kwargs):
	objective.send_to_graveyard()
	#kwargs["owner"].send_to_graveyard(kwargs["card"])


func increase_damage(objective, kwargs):
	pass


func add_temporaly_card(objective, kwargs):
	#Hacer versión exiliada de la carta
	objective.add_card(kwargs["card_name"])


func suffle_deck(objective, kwargs):
	objective.suffle_deck()


func set_energy(objective, kwargs):
	objective.set_energy(kwargs["amount"])


# TODO: Las cartas de daño pueden tener un atributo de tipo de daño
# (fuego/cortante/verdadero... y hay que gestionar eso cuando se juegan
	
