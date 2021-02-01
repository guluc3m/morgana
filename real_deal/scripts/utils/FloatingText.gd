extends Position2D

# https://www.youtube.com/watch?v=UlvBqz8bhCo

onready var label = $Label
onready var tween = $Tween
var text = null
var color = [0,0,0]

var speed = Vector2(0, 0)

func _ready():
	label.set_text(str(text))
	label.set("custom_colors/font_color", Color(self.color[0], self.color[1], self.color[2]))
	
	speed = Vector2(randi() % 41 - 20, 30)

	tween.interpolate_property(
		self, "scale", self.scale, Vector2(1, 1), 
		0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	# Último parametro es delay, que es el tiempo que tarda el primero en ejecutar
	tween.interpolate_property(
		self, "scale", Vector2(1, 1), Vector2(0.1, 0.1),
		0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2
	)
	tween.start()
	

func _on_Tween_tween_all_completed():
	self.queue_free()


func _process(delta):
	self.position -= speed * delta
