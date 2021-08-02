""" Aquí se realiza todo lo relacionado con la representación gráfica
	del item, tales como interacción con las interfaces, imágenes, efectos...
"""
extends Control

signal is_equipment

# Variable interna para contener al item
var item;
# Variable interna para luego en el front identificar
# con un booleano, nodos con y sin item
var with_item = false


func _ready():
	# TESTING ITEM
#	var test_item = load("res://real_deal/scripts/utils/player/Item.gd").new()
#	test_item.init_item('berry')
#	self.init_item(test_item)
	###########
	# Si esto no está aquí no se ajustan bien los márgenes para que esté centrado
	$Item.rect_min_size = $Item/Image/Background.rect_size*$Item/Image.scale
	$Item/Image/Background.set_margins_preset(Control.PRESET_CENTER)


func init_item(item):
	""" Para la instancia del objeto Item que se pasa por argumento
		cambia la imagen, etc y genera las cosas correspondientes
		para poder interactuar con el mismo
	"""
	self.item = item
	self.with_item = true
	var tmp_texture = ImageTexture.new()
	tmp_texture.load("res://assets/prototipos/elementos/items/{}.png".format([item.image], "{}"))
	$Item/Image.set_texture(tmp_texture);
	$Item.connect("gui_input", self, "_on_Item_gui_input")
	self.add_options_to_item()


func add_options_to_item():
	""" Añade al menú las posibles opciones que se pueden hacer
		con este item según su tipo y definición
	"""
	# TODO Añadir al menú de opciones las entradas y hacer sus "attachs" a las
	# funciones correspondientes
	var text = "";
	if self.item.type == "object":
		text = "Usar"
	elif self.item.type == "equipment":
		text = "Equipar"

	$Menu/ItemList.add_item(text)
	$Menu/ItemList.add_item("Descartar")


func use():
	""" Punto de entrada común para objetos y equipo
	"""
	self.item.use()
	if self.item.type == "equipment":
		emit_signal("is_equipment")
	# Después de usarlo podemos descartarlo (y así ahorramos código)
	self.drop()


func drop():
	""" Función para eliminar el objeto del inventario
	"""
	self.item.drop()
	self.item = null
	for i in range($Menu/ItemList.get_item_count()):
		$Menu/ItemList.remove_item(0)
	
	$Item.disconnect("gui_input", self, "_on_Item_gui_input")
	$Item/Image.set_texture(ImageTexture.new())
	# Si esto no está aquí no se ajustan bien los márgenes para que esté centrado
	$Item/Image/Background.set_margins_preset(Control.PRESET_CENTER)


func _on_Item_gui_input(event):
	""" Capturamos eventos para saber cuándo se hace click derecho para
		mostrar el menú
	"""
	if Input.is_action_just_released("mouse_left"):
		$Menu.visible = !$Menu.visible


func _on_ItemList_item_activated(index):
	var item_text = $Menu/ItemList.get_item_text(index)
	if item_text in ["Usar", "Equipar"]:
		self.use()
	elif item_text in ["Descartar"]:
		self.drop()
	
	$Menu.visible = false
	$Menu/ItemList.unselect_all()
