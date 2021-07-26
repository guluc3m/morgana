extends Control

signal a_coleccion;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init_image(card_tpye: String):
	pass


func _on_CartaMazo_gui_input(event):
	""" Evento para saber cuándo el usuario hace click y así eliminarla (visualmente)
		del mazo.
	"""
	if Input.is_action_just_released("mouse_left"):
		queue_free();
		emit_signal("a_coleccion", "pepe");
