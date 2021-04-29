extends Node
class_name DungeonManager

var rooms = [] # Lista con las salas que componen la mazmorra

func generate_dungeon():
	"""
	Función encargada de generar toda la mazmorra.
	La mazmorra se compone de salas, que son el espacio jugable por el jugador,
	que están conectadas mediante portales.
	"""

func change_room(room_id):
	"""
	Al activar un portal, la habitación actual se descarga y debe cargarse la nueva.
	Esto se hace a través del objeto portal que podría mandar una señal al gestor
	indicandole la nueva habitación a cargar.
	"""
	pass # TODO
	
func save():
	pass # TODO
