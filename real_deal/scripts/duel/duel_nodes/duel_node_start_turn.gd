extends "res://real_deal/scripts/duel/duel_nodes/duel_node.gd"

"""
Este nodo procesa los eventos de iniciar turno
"""
func _init(duel_manager).(duel_manager):
	pass
	
func process():
	print("Comienza el turno de " + _duel_manager.current_turn.name)
	_duel_manager.next_node()
