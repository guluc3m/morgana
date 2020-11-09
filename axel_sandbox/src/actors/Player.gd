extends Actor

signal open_door(body)
signal item_collision()

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
		if body.is_in_group("items"):
			emit_signal("item_collision")
		if body.is_in_group("doors"):
			emit_signal("open_door", body)

func _process(delta):
	var direction: = get_direction()
	_velocity = direction.normalized() * speed
	run_animation(delta)
	_velocity = move_and_slide(_velocity)
	var overlapping_bodies = $PlayerInfluece.get_overlapping_bodies()
	if Input.is_action_pressed('attack') and len(overlapping_bodies):
		process_overlapping_bodies_actions(overlapping_bodies)

func _on_CollisionObjects_body_entered(body):
	if body.is_in_group("traps"):
		process_traps()
	if body is KinematicBody2D and body.is_in_group("enemies"):
		print("Enemy killed")
		body.queue_free()
