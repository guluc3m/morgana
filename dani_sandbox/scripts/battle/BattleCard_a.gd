extends MarginContainer

onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
var card_name = "Placeholder"

var player = ""
var target = ""
var type = ""

var mouse_pos_init = null
var mouse_pos_end = null
var mouse_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	# Desactiva el input de inicio, ya que solo queremos que se dispare cuando se está encima de la carta
	set_process_input(false)
	
	var type = card_database[card_name]["type"]
	var cost = card_database[card_name]["cost"]
	var dexterity = card_database[card_name]["dexterity"]
	var description = card_database[card_name]["description"]
	$Bars/Mark.texture = load(str("res://assets/sprites/cards_marks/mark_" + type + ".png"))
	$Bars/Mark.scale *= rect_size/$Bars/Mark.texture.get_size()
	$Bars/Ilustration.texture = load(str("res://assets/sprites/cards_ilustrations/ilustration_" + card_name.to_lower() + ".png"))
	#$Ilustration.scale *= rect_size/$Ilustration.texture.get_size()
	$Bars/Colums/Cost/NinePatchRect/Number.text = str(cost)
	$Bars/Colums/Name/Name.text = card_name
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = str(dexterity)
	$Bars/Description/Description.text = description


func _on_BattleCardBase_pressed():
	# Esto habría que ver como implementarlo con las funciones de las cartas
	player.get_node("Character").animation = type
	if target:
		player.target = target
	player.emit_signal("playerAttack")
	player.get_node("Character").play()
	

func _draw():
	# Pinta la línea
	if mouse_pos_end:
		draw_line(mouse_pos_init, mouse_pos_end, Color(255, 0, 0), 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sin el update no se ejecuta _draw
	update()


func _input(event):
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
	# Esto funciona porque todos los nodos hijos tienes "mouse filter" a "pass"
	print("Enter")
	# Activa el input porque estamos encima de la carta
	set_process_input(true)


func _on_BattleCardBase_mouse_exited():
	# Esto funciona porque todos los nodos hijos tienes "mouse filter" a "pass"
	print("Out")
	# Desactiva el input porque hemos salido de la carta
	set_process_input(false)
