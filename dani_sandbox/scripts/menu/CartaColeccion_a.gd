extends Control

signal a_mazo


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init_image(card_tpye: String):
	pass
	
	
func _on_CartaColeccion_gui_input(event):
	""" Evento para saber cuándo el usuario hace click o hace click derecho en la carta
	"""
	if Input.is_action_just_released("mouse_left"):
		# Idealmente aquí se pasan los argumentos necesarios para que podamos
		# identificar la carta y añadirla correctamente.
		emit_signal("a_mazo", "pepe");
		
	if Input.is_action_just_released("mouse_right"):
		# TODO puede que haya que definirlo en los ajustes del proyecto
		print(event)
