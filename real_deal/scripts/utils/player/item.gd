""" Aquí se genera un objeto interno que representa al Item.
	
	Para una representación gráfica, ir a ItemNode.gd
"""

class_name Item
extends Object

var item_database = preload("res://real_deal/scripts/utils/ItemDatabase.gd").DATA
var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

var name;
var image;
var type;
var description;
var effects;
var add_cart;
var card_name;
var actions;


func init_item(key: String):
	""" Genera una instancia del objeto especificado por la clave
		y definido en ItemDatabase.gd
	"""
	self.name = item_database[key]['name']
	self.image = item_database[key]['image']
	self.type = item_database[key]['type']
	self.description = item_database[key]['description']
	self.effects = item_database[key]['effects']
	self.add_cart = item_database[key]['add_cart']
	self.card_name = item_database[key]['card_name']
	self.actions = item_database[key]['actions']


func use():
	""" Punto de entrada común para objetos y equipo
	"""
	if self.type == "object":
		self.consume()
	elif self.type == "equipment":
		self.equip()


func drop():
	""" Función para eliminar el objeto del inventario
	"""
	print("drop")
	

func consume():
	""" Función para usar el Item si es de tipo 'object'
	"""
	print("consume")
	for action in self.actions:
		var attr = action[0]
		var value = action[1]
		PlayerManager.set(attr, PlayerManager.get(attr) + value)


func equip():
	""" Función para equipar un objeto si es de tipo 'equipment'
	"""
	print("equip")
	if len(PlayerManager.equipped_items) < 4:
		PlayerManager.equipped_items.append(self)
	if self.add_cart:
		PlayerManager.deck.append(self.card_name)
	

func unequip():
	""" Función a llamar cuando se desequipa un objeto de tipo 'equipment'
	"""
	print("unequip")
	PlayerManager.equipped_items.remove(self)
	if self.add_cart:
		PlayerManager.deck.erase(self.card_name)
