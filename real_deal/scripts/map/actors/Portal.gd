extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hacia = ""
var abierto = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if not abierto:
		self.close_portal()


func close_portal():
	""" Cambia el sprite a la versión cerrada del portal
	"""
	$Sprite.texture = load("res://assets/prototipos/elementos/limb_portal_locked.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
