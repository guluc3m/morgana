extends Node
# https://docs.godotengine.org/es/stable/tutorials/io/saving_games.html
"""
El código principal de este fichero trata sobre la carga y guardado de escenas.
Sin embargo, hay estructuras de datos que se deben guardar como son el estado
global del jugador o el avance de la mazmorra.

Es necesario también ver cuando se puede guardar y diferenciar más adelante entre
guardado de estado para el propio juego (que puede que con los managers no sea necesario)
y el guardado para el jugador que con lleva dejar de correr el juego y retomarlo más adelante.
"""
var path_save_directory = "res://"

func _ready():
	var path = Directory.new()
	if(!path.dir_exists(path_save_directory + "saves")):
		path.open(path_save_directory)
		path.make_dir(path_save_directory + "saves")

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_game = File.new()
	var save_nodes = get_tree().get_nodes_in_group("Sensitive")
	if not save_nodes:
		return

	save_game.open(path_save_directory + "saves/savegame.sav", File.WRITE)
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	PlayerManager.save()
	save_game.close()

# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	print("Cargando")
	
	var save_game = File.new()
	if not save_game.file_exists(path_save_directory + "saves/savegame.sav"):
		return # Error! We don't have a save to load.
	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Sensitive")
	for i in save_nodes:
		i.free()
	
	save_nodes = get_tree().get_nodes_in_group("Sensitive")
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open(path_save_directory + "saves/savegame.sav", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		#new_object.name = node_data["name"]

		# Now we set the remaining variables.
		for i in node_data.keys():
			#print("keys", i)
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
	PlayerManager.load()
	save_game.close()
