extends MarginContainer


onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
var card_name = "Placeholder"


# Called when the node enters the scene tree for the first time.
func _ready():
	var type = card_database[card_name]["type"]
	var cost = card_database[card_name]["cost"]
	var dexterity = card_database[card_name]["dexterity"]
	var description = card_database[card_name]["description"]
	$Mark.texture = load(str("res://assets/sprites/cards_marks/mark_" + type + ".png"))
	$Mark.scale *= rect_size/$Mark.texture.get_size()
	$Ilustration.texture = load(str("res://assets/sprites/cards_ilustrations/ilustration_" + card_name.to_lower() + ".png"))
	#$Ilustration.scale *= rect_size/$Ilustration.texture.get_size()
	$Bars/Colums/Cost/NinePatchRect/Number.text = str(cost)
	$Bars/Colums/Name/Name.text = card_name
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = str(dexterity)
	$Bars/Description/Description.text = description
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
