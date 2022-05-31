extends Node2D


func _ready():
	pass
	# var r = get_tree().get_nodes_in_group("Sensitive")
	# r = get_tree().get_nodes_in_group("Sensitive")
	
	
# No recuerdo para que valia esto
func set_owner(clueless_nodes):
	for clueless_node in clueless_nodes:
		clueless_node.owner = self
		#set_owner(clueless_node.get_children())
	

func init_level(nombre_escena):
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
			var nodes = get_tree().get_nodes_in_group(k.to_lower())
			for node in nodes:
				var element = load("res://real_deal/scenes/map/actors/{}.tscn".format([k], "{}")).instance()
				element.position = node.position
				element.name = node.name
				node.queue_free()
				# Sobreescribimos atributos
				for vals in def_escena[k].keys():
					element.set_indexed(vals, def_escena[k][vals])
				get_tree().get_current_scene().call_deferred("add_child", element)
		# Caso tenemos que aplicar distintas propiedades a elementos en el mismo grupo
		elif typeof(def_escena[k]) == typeof(Array()):
			for subset in def_escena[k]:
				# Se aplica a un subset concreto de elementos en el grupo
				if typeof(subset["nombre"]) == typeof(Array()):
					var element_nodes = get_tree().get_nodes_in_group(k.to_lower())
					for sub_node in element_nodes:
						# Filtramos por los nodos que queremos
						if sub_node.name in subset['nombre']:
							var element = load("res://real_deal/scenes/map/actors/{}.tscn".format([k], "{}")).instance()
							element.position = sub_node.position
							element.name = sub_node.name
							sub_node.queue_free()
							# Sobreescribimos atributos
							for vals in subset.keys():
								if vals != "nombre":  # Ignoramos el nombre, ya que es un poco irrelevante
									print(vals, subset[vals])
									element.set_indexed(vals, subset[vals])
							get_tree().get_current_scene().call_deferred("add_child", element)
							
	# Cargamos el jugador, que siempre estará
	var jugador = load("res://real_deal/scenes/map/actors/Player.tscn").instance()
	jugador.connect("portal_collision", self, "cambiar_nivel")
	jugador.position = get_node("posiciones/jugador").position
	get_tree().get_current_scene().call_deferred("add_child", jugador)
	
	
func _enter_tree():
	GameSaver.load_game()
	self.set_owner(get_tree().get_nodes_in_group("Sensitive"))


func cambiar_nivel(portal_path):
	""" Función para interactuar con los portales
	"""
	var portal = get_node(portal_path)
	
	if not portal.abierto:
		return
	# TODO esto lo ideal es pasar algún tipo de "callback" o funciones extras" para no hacer casos concretos
	# A NO SER que solo vaya a existir este "if"
	if "limbo" in portal.hacia:
		PlayerManager.restore_player()
		
	SceneManager.goto_scene(
		"res://real_deal/scenes/map/{}.tscn".format([portal.hacia], "{}"),
		{"escena": portal.hacia}
	)


func update_data(data):
	""" Esta función tiene la finalidad de ajustar ciertos objetos a nuevos estados.
	Por ejemplo, al volver a la escena de exploración tras ganar un duelo, el grupo
	de enemigos ha desaparecido y el jugador a sufrido cambios en su vida, y probablemente
	en su cantidad de experiencia o botín.
	"""
	if 'escena' in data:
		self.init_level(data['escena'])
	
	# var r = get_tree().get_nodes_in_group("Sensitive")
	_update_player(data)
	_update_enemies(data)
	_update_env(data)
	
	
func _update_player(data):
	""" Actualiza datos en la instancia del jugador
	"""
	if 'player' in data:
		var player = get_tree().get_root().find_node("Player", true, false)
	
	
func _update_enemies(data):
	""" Actualiza datos en los enemigos
		En desuso, probablemente hay que eliminarlo
	"""
	pass
#	if 'enemy_defeat' in data:
#		var enemy = get_tree().get_root().find_node("EnemyOne", true, false)
#		if data["enemy_defeat"]:
#			enemy.queue_free()

func _update_env(data):
	""" Actualiza datos en el entorno.
		pj: Ocultar elementos, cambiar objetos, etc
		
		La estructura esperada de data debería ser lo siguiente:
		data: {
			'env': [{
				'nombre del nodo': [
					(atributo a cambiar, **parámetros esperados),
					...
				]
			},...]
		}
	"""
	if not ('env' in data):
		return

	for obj in data['env']:
		for obj_name in obj.keys():
			var node = get_tree().get_root().find_node(obj_name, true, false)
			# Se ejecutan las funciones definidas en el nodo
			for func_args in obj[obj_name]:
				if node.has_method(func_args[0]):
					if len(func_args) > 1:  # Función con 1 o + argumentos
						node.callv(func_args[0], func_args[1])
					else:  # Función sin argumentos
						node.call(func_args[0])
