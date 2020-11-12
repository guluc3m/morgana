extends Control

signal playerAttack

var player = ""
var target = ""
var type = ""

var mouse_pos_init = null
var mouse_pos_end = null
var mouse_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	set_process_input(false)


func _on_Button_pressed():
	player.get_node("Character").animation = type
	if target:
		player.target = target
	player.emit_signal("playerAttack")
	player.get_node("Character").play()


func _on_Button_mouse_entered():
	print("Enter")
	set_process_input(true)


func _on_Button_mouse_exited():
	# if not mouse_pressed:
	print("stop")
	set_process_input(false)
	

func _draw():
	if mouse_pos_end:
		draw_line(mouse_pos_init, mouse_pos_end, Color(255, 0, 0), 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func _input(event):
	
	if event.is_action_pressed("mouse_left"):
		mouse_pressed = true
		mouse_pos_init = get_local_mouse_position()

	if mouse_pressed and event.is_action_released("mouse_left"):
		set_process_input(false)
		mouse_pos_init = null
		mouse_pos_end = null
		mouse_pressed = false
	
	if mouse_pressed and event is InputEventMouseMotion:
		mouse_pos_end = get_local_mouse_position()
