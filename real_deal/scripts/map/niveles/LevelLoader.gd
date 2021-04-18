extends Node2D


func _ready():
	# Cuando la escena es la inicial y no una transición
	var nombre_escena = get_tree().get_current_scene()
	if nombre_escena:
		self.update_data(nombre_escena.get_name())
	
func update_data(nombre_escena):
	""" Carga las escenas correspondientes en las posiciones que le tocan
		Toda la información pertinente a los 'actores' definidos por las posiciones está definida en un
		JSON concreto de cada nivel. En este JSON se especifican los detalles de por ejemplo: 
			tipo de enemigo, consumible, cofres (rarezas o contenido)...
			
		Los grupos conocidos dependen del JSON correspondiente al mapa, deben corresponderse las claves
		del diccionario con los grupos definidos en el mismo:
			- jugador: Posición inicial del jugador
			- portal: Portal de finalización de la zona / cambio de nivel
			- enemigos: Posiciones iniciales de los enemigos, pueden además pertenecer a 'minijefes' o 'jefe'
			- cofres: posición de los cofres
			- consumible: posición de los consumibles
	"""
	#var nombre_escena = get_tree().get_current_scene().get_name()
	var file = File.new()
	file.open(
		"res://real_deal/scenes/map/niveles/{}.json".format([nombre_escena], "{}"),
		file.READ
	)
	var def_escena = JSON.parse(file.get_as_text()).result
	
	for k in def_escena.keys():
		# Caso aplicar mismas propiedades a todos en el grupo
		if typeof(def_escena[k]) == typeof(Dictionary()):
			var nodes = get_tree().get_nodes_in_group(k)
			for node in nodes:
				var element = load("res://real_deal/scenes/map/actors/{}.tscn".format([k], "{}")).instance()
				element.position = node.position
				# Sobreescribimos atributos
				for vals in def_escena[k].keys():
					element.set_indexed(vals, def_escena[k][vals])
				get_tree().get_root().call_deferred("add_child", element)
		# Caso tenemos que aplicar distintas propiedades a elementos en el mismo grupo
		elif typeof(def_escena[k]) == typeof(Array()):
			for subset in def_escena[k]:
				# Se aplica a un subset concreto de elementos en el grupo
				if typeof(subset["nombre"]) == typeof(Array()):
					var element_nodes = get_tree().get_nodes_in_group(k)
					for sub_node in element_nodes:
						# Filtramos por los nodos que queremos
						if sub_node.name in subset['nombre']:
							var element = load("res://real_deal/scenes/map/actors/{}.tscn".format([k], "{}")).instance()
							element.position = sub_node.position
							# Sobreescribimos atributos
							for vals in subset.keys():
								if vals != "nombre":  # Ignoramos el nombre, ya que es un poco irrelevante
									element.set_indexed(vals, subset[vals])
							get_tree().get_root().call_deferred("add_child", element)
				# Se aplica a un elemento individual del grupo
				elif typeof(subset["nombre"]) == typeof(Dictionary()):
					var element_node = get_tree().get_nodes_in_group(k)
					for sub_node in element_node:
						if sub_node.name == subset['nombre']:
							var element = load("res://real_deal/scenes/map/actors/{}.tscn".format([k], "{}")).instance()
							element.position = sub_node.position
							# Sobreescribimos atributos
							for vals in subset.keys():
								if vals != "nombre":  # Ignoramos el nombre, ya que es un poco irrelevante
									element.set_indexed(vals, subset[vals])
							get_tree().get_root().call_deferred("add_child", element)
					
	
	# Cargamos el jugador, que siempre estará
	var jugador = load("res://real_deal/scenes/map/actors/Player.tscn").instance()
	jugador.connect("portal_collision", self, "cambiar_nivel")
	jugador.position = get_node("posiciones/jugador").position
	get_tree().get_root().call_deferred("add_child", jugador)
	# var r = get_tree().get_nodes_in_group("Sensitive")
	# GameSaver.load_game()
	# r = get_tree().get_nodes_in_group("Sensitive")
	#set_owner(get_tree().get_nodes_in_group("Sensitive"))


func cambiar_nivel(portal_path):
	var portal = get_node(portal_path)
	SceneManager.goto_scene(
		"res://real_deal/scenes/map/{}.tscn".format([portal.hacia], "{}"),
		portal.hacia
	)
# No recuerdo para que valia esto
##?????????????????????????????????????????????????????????????????????????????
#func set_owner(clueless_nodes):
#	for clueless_node in clueless_nodes:
#		print(clueless_node.owner)
#		clueless_node.owner = self
#		print(clueless_node.owner)
		

#func update_data(data):
#	""" Esta función tiene la finalidad de ajustar ciertos objetos a nuevos estados.
#	Por ejemplo, al volver a la escena de exploración tras ganar un duelo, el grupo
#	de enemigos ha desaparecido y el jugador a sufrido cambios en su vida, y probablemente
#	en su cantidad de experiencia o botín.
#	"""
#	var r = get_tree().get_nodes_in_group("Sensitive")
#
#	_update_player(data)
#	_update_enemies(data)
#
#
#func _update_player(data):
#	# TODO rehacerlo (o este quizás no)
#	var player = get_tree().get_root().find_node("Player", true, false)
#	if data:
#		$Player.health = data["health"]
#
#
#func _update_enemies(data):
#	# TODO rehacerlo
#	var enemy = get_tree().get_root().find_node("EnemyOne", true, false)
#	if data["enemy_defeat"]:
#		enemy.queue_free()
