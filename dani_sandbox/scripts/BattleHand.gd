extends Control

var player = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: Resize de la carta para que se ajusten al alto de la mano proporcionalmente.
	# No es muy complicado (al menos matemáticamente)
	var cards = $hand.get_child_count()
	$hand.set_size(Vector2(get_viewport().get_visible_rect().size.x*0.28, 48))
