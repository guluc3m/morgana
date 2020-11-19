extends KinematicBody2D


export (bool) var full = false


func _on_Player_item_collision(body):
	if body == self:
		if full:
			$Sprite.play("open_full")
		else:
			$Sprite.play("open_empty")
