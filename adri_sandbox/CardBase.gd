extends MarginContainer


onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd").DATA
var card_data = null


# Called when the node enters the scene tree for the first time.
func _ready():
	var name = card_data["name"]
	var type = card_data["type"]
	var cost = card_data["cost"]
	var dexterity = card_data["dexterity"]
	var description = card_data["description"]
	$Mark.texture = load(str("res://assets/sprites/cards_marks/mark_" + type + ".png"))
	$Mark.scale *= rect_size/$Mark.texture.get_size()
	$Ilustration.texture = load(str("res://assets/sprites/cards_ilustrations/ilustration_" + name.to_lower() + ".png"))
	#$Ilustration.scale *= rect_size/$Ilustration.texture.get_size()
	$Bars/Colums/Cost/NinePatchRect/Number.text = str(cost)
	$Bars/Colums/Name/Name.text = name
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = str(dexterity)
	$Bars/Description/Description.text = description
	


