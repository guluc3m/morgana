extends MarginContainer


onready var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
onready var card_functions = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

var card_data = null
var card_target = null

var mouse_pos_init = null
var mouse_pos_end = null
var mouse_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	""" Inicializa valores necesarios para poder visualizar la carta
	"""
	set_process(true)
	# Desactiva el input de inicio, ya que solo queremos que se dispare cuando se está encima de la carta
	set_process_input(false)
	
	# var name = self.card_data["name"]
	# var type = card_data["type"]
	# var cost = self.card_data["cost"]
	# var dexterity = self.card_data["dexterity"]
	# var description = self.card_data["description"]
	
	$Background.texture = load(str("res://assets/sprites/cards/" + self.card_data["file"] + ".png"))
	
	$Bars/Colums/Cost/NinePatchRect/Number.text = str(self.card_data["cost"])
	$Bars/Colums/Name/Name.text = self.card_data["name"]
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = str(self.card_data["dexterity"])
	$Bars/Description/Description.text = self.card_data["description"]
	

func _draw():
	""" Pinta la línea que se usa para seleccionar al objetivo
	"""
	if self.mouse_pos_end:
		draw_line(self.mouse_pos_init, self.mouse_pos_end, Color(255, 0, 0), 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sin el update no se ejecuta _draw
	update()


func _input(event):
	""" Procesa eventos de I/O cuando se está sobre la carta
	"""
	if event.is_action_pressed("mouse_left"):
		#Aquí se añade a una lista los posibles objetivos de la carta
		self.mouse_pressed = true
		self.mouse_pos_init = get_local_mouse_position()
		add_to_group("card")
		
		if self.card_data["target"] in ["enemy", "both"]:
			for _target in get_tree().get_nodes_in_group("enemies"):
				if _target.is_alive():
					_target.add_to_group("targeteable")
					
		if self.card_data["target"] in ["player", "both"]:
			# Solo debería ser 1, pero como devuelve una lista...
			for _target in get_tree().get_nodes_in_group("player"):
				_target.add_to_group("targeteable")

	if self.mouse_pressed and event.is_action_released("mouse_left"):
		# Al soltar la carta sobre un objetivo, se aplica el efecto de la carta
		if self.card_target:
			print(get_path())
			get_tree().current_scene.emit_signal(
				"playCard", get_path(), self.card_data, self.card_target
			)
		self.release_card()
	
	if self.mouse_pressed and event is InputEventMouseMotion:
		# Actualiza posición para pintar la línea
		self.mouse_pos_end = get_local_mouse_position()


func _on_BattleCardBase_mouse_entered():
	""" Activa el input para poder seleccionar la carta y al objetivo
	"""
	# Esto funciona porque todos los nodos hijos tienes "mouse filter" a "pass"
	set_process_input(true)


func _on_BattleCardBase_mouse_exited():
	""" Desactiva el input para evitar conflictos al estar moviendo el ratón
		por la pantalla
	"""
	# Esto funciona porque todos los nodos hijos tienes "mouse filter" a "pass"
	set_process_input(false)


func get_target(target):
	""" Guarda el objetivo de la carta (en caso de ser jugada)
	"""
	self.card_target = target


func release_card():
	""" Resetea valores de la carta en caso de ser jugada/no jugada
	"""
	set_process_input(false)
	self.mouse_pos_init = null
	self.mouse_pos_end = null
	self.mouse_pressed = false
	
	for _target in get_tree().get_nodes_in_group("targeteable"):
		_target.emit_signal("not_card_target")
		_target.remove_from_group("targeteable")
	
	remove_from_group("card")
	self.card_target = false
