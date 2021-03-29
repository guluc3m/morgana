extends KinematicBody2D


export (bool) var full = false

func _on_Player_item_collision(body):
	print("me han llamaado ", body)
	if body == self:
		if full:
			$Sprite.play("open_full")
		else:
			$Sprite.play("open_empty")


func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"full" : full,
		"name" : "FullChest" if self.full else "EmptyChest"
	}
	return save_dict

