extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var cards = get_child_count()
	# set_custom_minimum_size(Vector2(40*cards, 48))
	# set_size(Vector2(get_viewport().get_visible_rect().size.x*0.28, 48))
	$hand.set_size(Vector2(get_viewport().get_visible_rect().size.x*0.28, 48))
	# $ColorRect.set_size(Vector2(get_viewport().get_visible_rect().size.x*0.28, 48))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
