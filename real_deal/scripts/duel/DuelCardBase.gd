extends Control

signal playCard

onready var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
onready var card_functions = preload("res://real_deal/scripts/duel/Effects.gd").new()
var card_data = null

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
	
	var name = card_data["name"]
	var type = card_data["type"]
	var cost = card_data["cost"]
	var dexterity = card_data["dexterity"]
	var description = card_data["description"]
	$Background.texture = load(str("res://assets/sprites/cards_marks/mark_" + type + ".png"))
	$Bars/Illustration.texture = load(str("res://assets/sprites/cards_ilustrations/ilustration_" + name.to_lower() + ".png"))
	#$Ilustration.scale *= rect_size/$Ilustration.texture.get_size()
	$Bars/Colums/Cost/NinePatchRect/Number.text = str(cost)
	$Bars/Colums/Name/Name.text = name
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = str(dexterity)
	$Bars/Description/Description.text = description
	

func _draw():
	""" Pinta la línea que se usa para seleccionar al objetivo
	"""
	if mouse_pos_end:
		draw_line(mouse_pos_init, mouse_pos_end, Color(255, 0, 0), 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sin el update no se ejecuta _draw
	update()


func _input(event):
	""" Procesa eventos de I/O cuando se está sobre la carta
	"""
	if event.is_action_pressed("mouse_left"):
		mouse_pressed = true
		mouse_pos_init = get_local_mouse_position()
		
		for _target in get_tree().get_nodes_in_group("enemies"):
			_target.add_to_group("targeteable")

	if mouse_pressed and event.is_action_released("mouse_left"):
		set_process_input(false)
		mouse_pos_init = null
		mouse_pos_end = null
		mouse_pressed = false
		
		for _target in get_tree().get_nodes_in_group("targeteable"):
			_target.remove_from_group("targeteable")
	
	if mouse_pressed and event is InputEventMouseMotion:
		mouse_pos_end = get_local_mouse_position()


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


# TODO
#func _on_BattleCardBase_pressed():
#	# Esto habría que ver como implementarlo con las funciones de las cartas
#	player.get_node("Character").animation = type
#	if target:
#		player.target = target
#	player.emit_signal("playerAttack")
#	player.get_node("Character").play()


func _on_BattleCardBase_playCard(target_id):
	""" Ejecuta las acciones de la carta
	"""
	# FALTARÍA QUE SE APLIQUE AL OBJETIVO
	for f in card_data['actions']:
		var funcion = funcref(card_functions, f[0])
		funcion.call_funcv(f[1])
