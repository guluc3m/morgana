extends Node2D


const CardBase = preload("res://adri_sandbox/CardBase.tscn")
const Compendium = ["Placeholder", "Sword", "Potion"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("ui_left"):
		var new_card = CardBase.instance()
		new_card.card_name = Compendium[randi() % 3]
		new_card.rect_position = get_global_mouse_position()
		#new_card.rect_s = new_card.rect_size
		$Cards.add_child(new_card)
