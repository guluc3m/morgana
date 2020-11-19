extends Area2D

var screen_size

func _ready():
	# hide()
	screen_size = get_viewport_rect().size
	play_idle()


func _process(delta):
	pass


func _on_Character_animation_finished():
	if $Character.animation == "attack":
		play_idle()


func play_idle():
	$Character.animation = "idle"
	$Character.play()
