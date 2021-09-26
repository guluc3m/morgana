class_name Inventory
extends Object
"""
Esta clase está destinada a ser la estructura de datos que gestione
los ITEMS que posee el jugador en su inventario.
"""
var Item = preload("res://real_deal/scripts/utils/player/Item.gd")

var _items = []
var _saved_items = ["helmet", "berry"]
# Deberíamos cambiarlo a un diccionario donde se guarden los objetos usando su referencia y el número de unidades


func _init():
	print("Inventario - jajaja")
	for item in _saved_items:
		var it = Item.new()
		it.init_item(item)
		self._items.append(it)
		
	
func add_item(item):
	_items.append(item)


func remove_item(item):
	var item_pos = _items.find(item)
	_items.remove(item_pos)


func get_item(item):
	var item_pos = _items.find(item)
	return _items[item_pos]


func get_items():
	return _items.duplicate()
