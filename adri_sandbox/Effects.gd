extends Node


func modify_health(objetives, amount):
	for objetive in objetives:
		objetive.modify_health(amount)

func base_damage(danio):
	print("Oh, no! he recibido " + danio + " puntos de daño.")

func apply_condition(danio, condition):
	print("Oh, no! estoy " + condition + " y eso me hace " + danio + " puntos de daño.")

func set_armor(objetives, amount):
	for objetive in objetives:
		objetive.set_armor(amount)
		
func draw_card(objetives, amount):
	for objetive in objetives:
		objetive.draw_card(amount)
		
func exile_card(card):
	# Será usada si hay cartas que tengan el poder de exiliar otras cartas
	pass
	
func destroy_card(card, owner):
	owner.send_to_graveyard(card)
	
func increase_damage(objetives, amount):
	pass
	
func add_temporally_card(objetives, card_name):
	#Hacer versión exiliada de la carta
	for objetive in objetives:
		objetive.add_card(card_name)
		
func suffle_deck(objetives):
	for objetive in objetives:
		objetive.suffle_deck()
		
func set_energy(objetives, amount):
	for objetive in objetives:
		objetive.set_energy(amount)
		
		
# TODO: Las cartas de daño pueden tener un atributo de tipo de daño
# (fuego/cortante/verdadero... y hay que gestionar eso cuando se juegan
	
