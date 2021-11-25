extends "res://real_deal/scripts/duel/duel_nodes/duel_node.gd"

"""
Este nodo procesa los efectos de los estados de type on finish
"""
func _init(duel_manager).(duel_manager):
	pass
	
func process():
	print("Aplico los estados de " + _duel_manager.current_turn.name)
	_duel_manager.current_turn.process_states("on_finish")
		
	_duel_manager.next_node()
