extends Actor
class_name Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data


# Called when the node enters the scene tree for the first time.
func _ready():
	data = EnemiesDatabase.DATA["normal_slime"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
