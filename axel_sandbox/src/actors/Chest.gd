extends KinematicBody2D


export (bool) var full = false


func _on_Player_item_collision():
	print(self)
	if full:
		$Sprite.play("open_full")
	else:
		$Sprite.play("open_empty")
