extends Control

# Reference https://www.youtube.com/watch?v=p1l0M8u5EVc

# Señal para comunicar a la escena donde se carga el menú
# que tiene que borrar el nodo
signal CloseOptionsMenu

func _on_Close_pressed():
	emit_signal("CloseOptionsMenu")
