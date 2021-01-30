extends Control

# Reference https://www.youtube.com/watch?v=p1l0M8u5EVc

signal CloseOptionsMenu

func _on_Close_pressed():
	emit_signal("CloseOptionsMenu")
