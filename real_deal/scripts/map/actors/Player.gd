extends Actor

onready var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
onready var inventory_node = preload("res://real_deal/scenes/menu/Inventory.tscn")

signal portal_collision
signal chest_collision
signal item_collision

var velocity = Vector2(0,0)


func _ready():
	pass
	# TODO
#	var Item = load("res://real_deal/scripts/utils/player/Item.gd")
#	var item = Item.new()
#	item.init_item("berry")
#	PlayerManager.inventory.add_item(item)
#	PlayerManager.inventory.add_item(item)


func _input(event):
	if event.is_action_released("inventory"):
		var inv = get_node_or_null("Inventory")
		if inv:
			# Elimina el nodo del árbol
			remove_child(inv)
		else:
			# La añade al árbol
			add_child(inventory_node.instance())
		
		# Conectamos su señal con la función presente en este fichero (nombre señal, script que se enlaza, función del script)
		#get_node("OptionsMenu").connect("CloseOptionsMenu", self, "close_options_menu")
		# SceneManager.goto_scene("res://real_deal/scenes/menu//MainMenu.tscn", null)


func get_direction() -> Vector2:
	self.velocity = Vector2(0,0)
	
	if Input.is_action_pressed('down'):
		$Sprite.play("walk-down")
		velocity.y += 1
	elif Input.is_action_pressed('up'):
		$Sprite.play("walk-up")
		velocity.y -= 1
	if Input.is_action_pressed('right'):
		$Sprite.play("walk-side")
		velocity.x += 1
	elif Input.is_action_pressed('left'):
		$Sprite.play("walk-side")
		velocity.x -= 1
	
	return velocity


func is_movement() -> bool:
	if (Input.is_action_pressed('right') or Input.is_action_pressed('left') or
		Input.is_action_pressed('down') or Input.is_action_pressed('up')):
		return true
	else:
		return false


func run_animation():
	if is_movement():
		$Sprite.flip_h = _velocity.x < 0
	else:
		$Sprite.play("idle")


func _process(delta):
	var direction = get_direction()
	_velocity = direction.normalized() * speed
	run_animation()
	_velocity = move_and_slide(_velocity)


func _on_PlayerInfluece_body_entered(body):
	if body.is_in_group("portal"):
		emit_signal("portal_collision", body.get_path())
		
	elif body.is_in_group("chest"):
		emit_signal("chest_collision", body.get_path())
		
	elif body is KinematicBody2D and body.is_in_group("enemies"):
		# Si el jugador pierde irá hacia "atrás" y si gana, pues el enemigo ya no está
		body.queue_free()
		print("env", body.post_event)
		SceneManager.goto_scene(
			"res://real_deal/scenes/duel/DuelManager.tscn",
			{
				"enemigos": body.enemies,
				"env": body.post_event
			},
			true
		)
