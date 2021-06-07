extends Actor
class_name EnemyGroup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# El grupo se define por los nombres de los enemigos que lo componen.
# Todos sus datos son accesibles con el nombre en la base de datos.
export var enemies = ["normal_slime"]#, "fire_slime"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass#data = EnemiesDatabase.DATA["normal_slime"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# TIENES QUE APAÑAR LA CARGA DE ENEMIGOS.
# ESTAS TENIENDO PROBLEMAS PORQUE LOS DATOS LOS TIENEN LOS OBJETO ENEMIGO Y
# POR COMO SE CARGA LA ESCENA DE DUELO HAY CONFLICTOS
# DEBERÍAS MODIFICAR COMO SE HACE LA INICIALIZACIÓN DEL DUELO PARA QUE SEA MÁS
# LIMPIA Y SE COMUNIQUE MEJOR CON EL MANEJADOR DE ESCENAS
