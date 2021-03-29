extends ActorA

onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
onready var funciones = preload("res://adri_sandbox/Effects.gd").new()

signal open_door
signal item_collision

func _ready():
	# TODO
	# Pasar a generico por grupo de objetos
	# Ver si hay alguna forma de que no de error y funcione
	var empty_chest = get_tree().get_root().find_node("EmptyChest", true, false)
	var full_chest = get_tree().get_root().find_node("FullChest", true, false)
	var door = get_tree().get_root().find_node("Door", true, false)
	# Es un hijo de puta y siempre da un error
	self.disconnect("item_collision", empty_chest, "_on_Player_item_collision")
	self.disconnect("item_collision", full_chest, "_on_Player_item_collision")
	self.disconnect("open_door", door, "_on_Player_open_door")
	self.connect("item_collision", empty_chest, "_on_Player_item_collision")
	self.connect("item_collision", full_chest, "_on_Player_item_collision")
	self.connect("open_door", door, "_on_Player_open_door")


func get_direction() -> Vector2:
	var velocity: = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	return velocity

func is_movement() -> bool:
	if (Input.is_action_pressed('right') or Input.is_action_pressed('left') or
		Input.is_action_pressed('down') or Input.is_action_pressed('up')):
		return true
	else:
		return false

func run_animation(delta):
	if Input.is_action_pressed('attack') and _time_since_attack < attack_timer:
		$Sprite.play("attack")
		_time_since_attack += delta
		#print(get_tree().get_nodes_in_group("Sensitive"))
		#for nooo in get_tree().get_nodes_in_group("Sensitive"):
			#print(nooo.get_children())
	elif Input.is_action_just_released('attack'):
		_time_since_attack = 0.0
	elif is_movement():
		$Sprite.play("walk")
		$Sprite.flip_h = _velocity.x < 0
	else:
		$Sprite.play("idle")

func process_traps():
	print("Player dies")
	get_tree().quit()

func process_overlapping_bodies_actions(overlapping_bodies):
	for body in overlapping_bodies:
		print(body, body.is_in_group("items"))
		if body.is_in_group("items"):
			print("llamando")
			emit_signal("item_collision", body)
			print("llamado")
		if body.is_in_group("doors"):
			emit_signal("open_door", body)

func _process(delta):
	var direction: = get_direction()
	_velocity = direction.normalized() * speed
	run_animation(delta)
	_velocity = move_and_slide(_velocity)



func _input(event):
	if Input.is_action_pressed("ui_right"):
		SceneManager.goto_scene("res://adri_sandbox/MainMenu.tscn", null)
	var overlapping_bodies = $PlayerInfluece.get_overlapping_bodies()
	if event.is_action_pressed("attack") and len(overlapping_bodies):
		process_overlapping_bodies_actions(overlapping_bodies)

func _on_CollisionObjects_body_entered(body):
	if body.is_in_group("traps"):
		# TODO: move [65:69] to GameManager
		for card in ["Sword", "Potion", "Fire"]:
			for i in card_database[card]["actions"]:
				var funcion = funcref(funciones, i[0])
				funcion.call_funcv(i[1])
			print()

		process_traps()
	if body is KinematicBody2D and body.is_in_group("enemies"):
		print("Enemy killed")
		body.queue_free()
		SceneManager.goto_scene("res://real_deal/scenes/duel/DuelManager.tscn")


# Adri things for save manager
func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"name" : "Player"
	}
	return save_dict
