extends Node
class_name Room

var map = null # Aquí va el mapa en una matriz para construir la mazmorra
var chests = [] # Aquí se guardan instancias de Chests
var enemies_groups = [] # Aquí se guardan instancias de grupos de enemigos
var player_position = null # La posición en la que aparece el jugador
var portals = [] # Los portales para transitar
	
func remove_enemy_group(enemy_group_id):
	"""
	Al derrotar a un grupo de enemigos, se debe mostrar el mensaje con la recompensa
	que se actualiza en el inventario del jugador y se elemina el grupo de la habitación.
	"""
	pass # TODO
	
func save():
	pass # TODO
