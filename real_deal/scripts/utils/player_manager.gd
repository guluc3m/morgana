extends Node
#class_name PlayerManager

"""
Esta clase contiene todos los datos del jugador. Es un singleton que consultarán
y actualizaran otras clases con el fin de centralizar el estado del jugador a la
hora de mostrar menús, iniciar duelos o mostrar la interfaz (al menos durante
la exploración).
"""
var path_save_directory = "res://saves/save_player.sav"

var deck # Contiene los datos de las cartas que posee el jugador en su deck
var inventory # Contiene los objetos que posee el jugador

var max_hand_size
var draw_amount
var health
var max_health
var energy
var max_energy

func _ready():
	max_hand_size = 5
	draw_amount = 3
	health = 50
	max_health = 50
	energy = 3
	max_energy = 3
	
	deck = [
		"attack_1",
		"attack_1",
		"attack_1",
		"attack_2",
		"attack_2",
		"attack_2",
		"attack_3",
		"attack_3",
		"potion",
		"potion",
		"fire",
		"fire"
	]
	inventory = []
	

func restore_player():
	""" Pone la vida y la energía al máximo
	"""
	self.health = self.max_health
	self.energy = self.max_energy


func save():
	var save_game = File.new()
	save_game.open(path_save_directory, File.WRITE)
	var save_dict = {
		"max_hand_size": max_hand_size,
		"draw_amount": draw_amount,
		"health": health,
		"max_health": max_health,
		"energy": energy,
		"max_energy": max_energy,
		"deck": deck,
		"inventory": inventory
	}
	save_game.store_line(to_json(save_dict))
	save_game.close()


func load():
	var save_game = File.new()
	save_game.open(path_save_directory, File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())
		for i in node_data.keys():
			#print("keys", i)
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			self.set(i, node_data[i])
	save_game.close()
