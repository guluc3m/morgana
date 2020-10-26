extends Area2D


var screen_size

func _ready():
	# hide()
	screen_size = get_viewport_rect().size
	$Character.animation = "idle"
	$Character.play()
	
# func _process(delta):
#    pass
