class_name Inventory
extends Object
"""
Esta clase está destinada a ser la estructura de datos que gestione
los ITEMS que posee el jugador en su inventario.
"""

var _items = []
# Deberíamos cambiarlo a un diccionario donde se guarden los objetos usando su referencia y el número de unidades

func _init():
	print("jajaja")
	
func add_item(item):
	_items.append(item)

func remove_item(item):
	_items.remove(item)
	
func get_item(item_type):
	print("get_item IS NOT IMPLEMENTED")
	
func get_items():
	return _items.duplicate()
