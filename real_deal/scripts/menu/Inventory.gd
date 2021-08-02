extends CanvasLayer

onready var Item = preload("res://real_deal/scenes/utils/Item.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#### TAB PERSONALIZACIÓN ####
	self.init_tab_personalizacion();
	#### TAB MAZO ####
	self.init_tab_mazo();


func draw_equipped_items():
	""" Dibuja los objetos equipados
	"""
	print("draw")
	var equipo_node = $Container/TabContainer/PanelPJ/HBox/Equipo;
	var player_equipped = PlayerManager.equipped_items
	for n in equipo_node.get_node("MarginContainer/ItemsContainer/Items").get_children():
		equipo_node.get_node("MarginContainer/ItemsContainer/Items").remove_child(n)
		n.queue_free()
		
	for item in player_equipped:
		# Rellenamos con los items del jugador
		var itemNode = Item.instance()
		itemNode.init_item(item)
		itemNode.connect("is_equipment", self, "draw_equipped_items")
		equipo_node.get_node("MarginContainer/ItemsContainer/Items").add_child(itemNode);
	
	var item_count = equipo_node.get_node("MarginContainer/ItemsContainer/Items").get_child_count()
	while item_count == 0 or item_count < 4:
		# Rellenamos con casillas vacías
		var itemNode = Item.instance()
		itemNode.connect("is_equipment", self, "draw_equipped_items")
		equipo_node.get_node("MarginContainer/ItemsContainer/Items").add_child(itemNode);
		item_count += 1
	
func init_tab_personalizacion(items=[]):
	""" Inicializa las dimensiones y cosas correspondientes al tab
		de personalización.
	"""
	# Establece tamaños, ya que dependen de los padres.
	var panel_node = $Container/TabContainer/PanelPJ;
	var equipo_node = $Container/TabContainer/PanelPJ/HBox/Equipo;
	var stats_node = $Container/TabContainer/PanelPJ/HBox/Stats;
	
	# Contenedores principales
	equipo_node.rect_min_size = Vector2(panel_node.get_size().x*0.3, equipo_node.get_size().y);
	stats_node.rect_min_size = Vector2(panel_node.get_size().x*0.65, stats_node.get_size().y);
	
	# Contenedor objetos equipados
	self.draw_equipped_items()
		
	equipo_node.get_node("MarginContainer").add_constant_override("margin_left", 50);
	equipo_node.get_node("MarginContainer").add_constant_override("margin_top", 50);
	equipo_node.get_node("MarginContainer").add_constant_override("margin_right", 0);
	########################
	
	# Contenedor items
	# Iteramos por los objetos del jugador
	var player_items = PlayerManager.inventory.get_items()
	for item in player_items:
		# Rellenamos con los items del jugador
		var itemNode = Item.instance()
		itemNode.init_item(item)
		itemNode.connect("is_equipment", self, "draw_equipped_items")
		stats_node.get_node("VBox/ItemsCenter/Grid").add_child(itemNode);
	
	var item_count = stats_node.get_node("VBox/ItemsCenter/Grid").get_child_count()
	while item_count == 0 or item_count % 12 != 0:
		# Rellenamos con casillas vacías
		var itemNode = Item.instance()
		itemNode.connect("is_equipment", self, "draw_equipped_items")
		stats_node.get_node("VBox/ItemsCenter/Grid").add_child(itemNode);
		item_count += 1
	
	stats_node.get_node("VBox/ItemsCenter/Grid").add_constant_override("hseparation", 20)
	stats_node.get_node("VBox/ItemsCenter/Grid").add_constant_override("vseparation", 20)
	
	stats_node.get_node("VBox/ItemsCenter").rect_min_size.y = stats_node.rect_min_size.y/2;
	stats_node.get_node("VBox/ItemsCenter").rect_min_size.x = stats_node.rect_min_size.x;
	stats_node.get_node("VBox/ItemsCenter").add_constant_override("margin_left", 50);
	stats_node.get_node("VBox/ItemsCenter").add_constant_override("margin_top", 50);
	########################
	
	# Contenedor estadísticas
	stats_node.get_node("VBox/Stats/Text").text = "AAAA CHUGUENÑAAAA CHIBABA ULIASNDJADjaiDISAD";
	stats_node.get_node("VBox/Stats").rect_min_size.y = stats_node.rect_min_size.y/2;
	#########################


func create_node_collection(card_name: String):
	var inst = load("res://real_deal/scenes/menu/CartaColeccion.tscn").instance();
	inst.init_image(card_name);
	inst.connect("a_mazo", self, "_on_from_collection_to_deck");
	return inst;


func create_node_deck(card_name: String):
	var inst = load("res://real_deal/scenes/menu/CartaMazo.tscn").instance();
	inst.init_image(card_name);
	return inst;


func init_tab_mazo(coleccion=[], cartas=[]):
	""" Inicializa las dimensiones y cosas correspondientes al tab
		de edición de mazo.
	"""
	# Establece tamaños, ya que dependen de los padres.
	var mazo_node = $Container/TabContainer/Mazo;
	var coleccion_node = $Container/TabContainer/Mazo/VBox/HBoxCartas/Coleccion;
	var cartas_node = $Container/TabContainer/Mazo/VBox/HBoxCartas/Cartas;
	# Contenedores principales
	$Container/TabContainer/Mazo/VBox/HBoxCartas.rect_min_size.y = mazo_node.get_size().y*0.9;
	# Contenedor coleción cartas
	coleccion_node.rect_min_size = Vector2(mazo_node.get_size().x*0.6, coleccion_node.get_size().y);
	coleccion_node.get_node("ScrollContainer").rect_min_size.x = coleccion_node.get_size().x;
	
	# Contenedor cartas equipadas
	cartas_node.rect_min_size = Vector2(mazo_node.get_size().x*0.3, cartas_node.get_size().y);
	for k in PlayerManager.deck:
		PlayerManager.card_collection[k] -= 1;  # Se reduce el nº de cartas disponibles
		cartas_node.get_node(
			"ScrollContainer/Grid"
		).add_child(create_node_deck(k));
		
	# Cartas de la colleccion
	for k in PlayerManager.card_collection.keys():
		coleccion_node.get_node(
			"ScrollContainer/CenterGrid/Grid"
		).add_child(create_node_collection(k));
	
	cartas_node.get_node("ScrollContainer/Grid").rect_min_size.x = cartas_node.get_size().x;


func _on_from_collection_to_deck(card_name):
	""" Función que se llama cuando se quiere añadir una carta de la colección
		al mazo (previo guardar)
	"""
	print(self, card_name);
	var cartas_node = $Container/TabContainer/Mazo/VBox/HBoxCartas/Cartas;
	
	# Añadimos el nodo en la jerarquía
	cartas_node.get_node("ScrollContainer/Grid").add_child(
		create_node_deck(card_name)
	);


func _on_Aceptar_pressed():
	""" Función que se llama cuando el jugador quiere guardar el mazo
		actual como el mazo de juego
	"""
	# TODO Aquí se actualiza el mazo del jugador con el seleccionado
	# Para ello se recorre el elemento de la GUI que tiene todos los nodos
	# y nos quedamos con sus nombres/identificadores. 
	
	# Y cerramos el menú
	queue_free();


func _on_Cerrar_pressed():
	""" Cerrar el desplegable sin guardar ningún cambio en el mazo
	"""
	queue_free();
