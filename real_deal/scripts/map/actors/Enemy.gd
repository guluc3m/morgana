extends Actor
class_name Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Esta variable se define en el json del nivel
export var enemies = []  #"normal_slime", "fire_slime", "fire_slime"]
var post_event = []
# Variable donde se almacenan eventos y cambios que haya que
# ejecutar posterior al combate. Se ejecutaría llamando en el
# levelLoader a update_data con la clave 'env' en los datos

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemies[0]
	var name = enemy.split("-")[0]
	var type = enemy.split("-")[1]
	var level = enemy.split("-")[2]
	
	if type == "basico":
		pass
	elif type == "minijefe":
		self.scale *= Vector2(1.25, 1.25)
	
	$AnimatedSprite.frames = load("res://assets/animations/{}.tres".format([name], "{}"))
	$AnimatedSprite.animation = "idle"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# MIRAR PORQUE ESTE SCRIPT Y EL DE ENEMY GROUP ESTÁN DUPLICADOS
