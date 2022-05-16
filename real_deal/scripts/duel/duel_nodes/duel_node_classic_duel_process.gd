extends "res://real_deal/scripts/duel/duel_nodes/duel_node.gd"

"""
Este nodo contiene el process que tenia originalmente el duel manager
con la intención de aproximarnos progresivamente a la estructura de nodos.
Es necesario hacer todo esto así porque aún no tenemos la suficiente soltura
con señales como para poder subdividir esto correctamente.
"""
func _init(duel_manager).(duel_manager):
	pass
	
func process():
	if _duel_manager.current_turn == _duel_manager.player:
		if _duel_manager.current_turn.is_alive():
			if _duel_manager._are_enemies_dead():
				_duel_manager._player_win_duel()
			return
		else:
			_duel_manager._player_lose_duel()
			return
	# Enemy turn 
	if _duel_manager.current_turn.is_alive():
		var card_to_play = _duel_manager.current_turn.select_card()
		while card_to_play:
			_duel_manager._on_Main_playCard(
				null,
				card_to_play,
				_duel_manager.player
			)
			card_to_play = _duel_manager.current_turn.select_card()
	_duel_manager._on_finish_turn()
