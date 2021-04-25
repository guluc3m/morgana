extends CanvasLayer

# Reference: https://www.youtube.com/watch?v=p1l0M8u5EVc


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_OptionsButton_pressed():
	# Carga la escena
	var optionsMenu = load("res://real_deal/scenes/menu/OptionsMenu.tscn").instance()
	# La añade al árbol
	add_child(optionsMenu)
	# Conectamos su señal con la función presente en este fichero (nombre señal, script que se enlaza, función del script)
	get_node("OptionsMenu").connect("CloseOptionsMenu", self, "close_options_menu")
	
func close_options_menu():
	# Cierra la ventana de opciones
	get_node("OptionsMenu").queue_free()


func _on_Quit_pressed():
	# Cierra el juego
	get_tree().quit()


func _on_Start_pressed():
	# Cambia la escena al juego
	SceneManager.goto_scene("res://real_deal/scenes/map/mvp_limbo.tscn", {"escena": "mvp_limbo"})
