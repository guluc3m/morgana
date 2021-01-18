extends Node2D

#var next_scene = preload("res://axel_sandbox/src/levels/LevelTemplate.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://axel_sandbox/src/levels/LevelTemplate.tscn")
