extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#### TAB PERSONALIZACIÓN ####
	self.init_tab_personalizacion();
	#### TAB MAZO ####
	self.init_tab_mazo();
	
	
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
	stats_node.rect_min_size = Vector2(panel_node.get_size().x*0.6, stats_node.get_size().y);
	
	# Contenedor equipo
	
	# Contenedor estadísticas
	# https://godotengine.org/qa/64764/adding-a-texturerect-multiple-times-as-a-child
	# PLACEHOLDER TEMPORALES PARA PODER VER ALGO
	for i in range(12):  # TODO Aquí sustituir con lo que tenga el jugador en este momento.
		var texture_rect = TextureRect.new();
		texture_rect.texture = load("res://assets/sprites/cards_ilustrations/ilustration_placeholder.png");
		stats_node.get_node("VBox/Items/Grid").add_child(texture_rect);
		
	stats_node.get_node("VBox/Stats/Text").text = "AAAA CHUGUENÑAAAA CHIBABA ULIASNDJADjaiDISAD";
		
	stats_node.get_node("VBox/Items").rect_min_size.y = stats_node.rect_min_size.y/2;
	stats_node.get_node("VBox/Stats").rect_min_size.y = stats_node.rect_min_size.y/2;
	
	
func init_tab_mazo(colleccion=[], cartas=[]):
	""" Inicializa las dimensiones y cosas correspondientes al tab
		de edición de mazo.
	"""
	# Establece tamaños, ya que dependen de los padres.
	var mazo_node = $Container/TabContainer/Mazo;
	var colleccion_node = $Container/TabContainer/Mazo/VBox/HBoxCartas/Colleccion;
	var cartas_node = $Container/TabContainer/Mazo/VBox/HBoxCartas/Cartas;
	# Contenedores principales
	$Container/TabContainer/Mazo/VBox/HBoxCartas.rect_min_size.y = mazo_node.get_size().y*0.9;
	# Contenedor colleción cartas
	colleccion_node.rect_min_size = Vector2(mazo_node.get_size().x*0.6, colleccion_node.get_size().y);
	for i in range(40):  # TODO Aquí sustituir con "collección"
		var texture_rect = TextureRect.new();
		texture_rect.texture = load("res://assets/sprites/cards_ilustrations/ilustration_placeholder.png");
		colleccion_node.get_node("ScrollContainer/Grid").add_child(texture_rect);
	
	# Contenedor cartas equipadas
	cartas_node.rect_min_size = Vector2(mazo_node.get_size().x*0.3, cartas_node.get_size().y);
	
	for i in range(10):  # TODO Aquí sustituir con "cartas"
		cartas_node.get_node("ScrollContainer/VBoxContainer").add_child(
			load("res://dani_sandbox/scenes/menu/CartaMazo.tscn").instance()
		);


func _on_Aceptar_pressed():
	# TODO Aquí se actualiza el mazo del jugador con el seleccionado
	
	# Y cerramos el menú
	queue_free();


func _on_Cerrar_pressed():
	queue_free();
