extends MarginContainer


onready var card_database = preload("res://adri_sandbox/CardsDatabase.gd")
var card_name = "Sword"


# Called when the node enters the scene tree for the first time.
func _ready():
	var type = card_database[card_name]["type"]
	var cost = card_database[card_name]["cost"]
	var dexterity = card_database[card_name]["dexterity"]
	var description = card_database[card_name]["description"]
	var illustration = card_database[card_name]["illustration"]
	$Mark.texture = str("res://assets/sprites/cards_marks/" + card_database[card_name] + ".png")
	$Mark.scale *= rect_size/$Mark.texture.get_size()
	$Ilustration.texture = str("res://assets/sprites/cards_ilustrations/" + card_name + ".png")
	$Ilustration.scale *= rect_size/$Ilustration.texture.get_size()
	$Bars/Colums/Cost/NinePatchRect/Number.text = cost
	$Bars/Colums/Name/Name.text = card_name
	$Bars/Colums/Dexterity/NinePatchRect2/Number.text = card_name
	$Bars/Description/Description.text = description
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
