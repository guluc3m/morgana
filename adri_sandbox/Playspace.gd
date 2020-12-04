extends Node2D

onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
const CardBase = preload("res://adri_sandbox/CardBase.tscn")
const Compendium = ["Placeholder", "Sword", "Potion"]
const player = preload("res://adri_sandbox/DuelPlayer.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	#var new_card = CardBase.instance()
#	var p1 = player.new(5, ["Sword", "Potion", "Fire", "Placeholder", "Sword", "Potion"] ,5 ,5 ,5,56)
#	print(p1._deck)
#	print(p1._hand)
#	print(p1._graveyard)
#	print("\n\n")
#	p1.add_temporally_card_to_deck("Fire")
#	print(p1._deck)
#	print(p1._hand)
#	print(p1._graveyard)
	pass

func _input(event):
	if Input.is_action_just_released("ui_left"):
		var new_card = CardBase.instance()
		new_card.card_data = card_database[Compendium[randi() % 3]]
		new_card.rect_position = get_global_mouse_position()
		#new_card.rect_s = new_card.rect_size
		$Cards.add_child(new_card)




#MIRA A VER SI SEPARAS LA CLASE DE LA ESTRCUTURA
