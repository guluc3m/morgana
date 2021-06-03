extends Actor

onready var card_database = preload("res://real_deal/scripts/utils/CardsDatabase.gd").DATA
onready var funciones = preload("res://real_deal/scripts/duel/CardEffects.gd").new()

signal portal_collision
signal item_collision


func _ready():
	# TODO
	pass
	
	
#func _input(event):
#	if Input.is_action_pressed("ui_right"):
#		SceneManager.goto_scene("res://real_deal/scenes/menu//MainMenu.tscn", null)


func get_direction() -> Vector2:
	var velocity: = Vector2()
	if Input.is_action_pressed('down'):
		$Sprite.play("walk-down")
		velocity.y += 1
	elif Input.is_action_pressed('up'):
		$Sprite.play("walk-up")
		velocity.y -= 1
	elif Input.is_action_pressed('right'):
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
	var direction: = get_direction()
	_velocity = direction.normalized() * speed
	run_animation()
	_velocity = move_and_slide(_velocity)


func _on_PlayerInfluece_body_entered(body):
	if body.is_in_group("portal"):
		emit_signal("portal_collision", body.get_path())
		
	if body is KinematicBody2D and body.is_in_group("enemies"):
		body.queue_free()
		SceneManager.goto_scene(
			"res://real_deal/scenes/duel/DuelManager.tscn",
			{"enemigos": body.enemies},
			true
		)
