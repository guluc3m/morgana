extends "res://real_deal/scripts/duel/DuelCharacter.gd"

signal card_target
signal not_card_target
signal playCard

var player = false # Comprobar si sobra
var mouse_over = false

# Enemy Data
var enemy_name = ""
var enemy_class = ""
var type = ""
var level = ""
var strategy = ""
var skills = []
var loot = []


var _sprite


func _ready():
	add_to_group("enemies")
	_healthBar = $HealthBarContainer/Container/HealthBar
	_sprite = $Character
	_ui_states = $StatesContainer/States
	# Se añaden al grupo de "targetebles" cuando se empieza a usar una carta
	# para evitar colisiones cuando no debe
	## add_to_group("targeteable")

func set_data(enemy_data):
	self._init_params(
		enemy_data["deck"],
		false,
		enemy_data["max_hand_size"],
		enemy_data["max_health"],
		enemy_data["max_health"],
		enemy_data["max_energy"],
		enemy_data["max_energy"]
	)
	_healthBar.max_value = enemy_data["max_health"]
	_healthBar.value = _healthBar.max_value
	self.enemy_name = enemy_data["name"]
	_sprite.frames = load("res://assets/animations/{}.tres".format([enemy_data["animation"]], "{}"))
	_sprite.animation = "idle"
	self.enemy_class = enemy_data["class"]
	self.type = enemy_data["type"]
	self.level = enemy_data["level"]
	self.strategy = enemy_data["strategy"]
	self.skills = enemy_data["skills"]
	self.loot = self._generate_loot(enemy_data["loot"])

func modify_health(amount):
	.modify_health(amount)
	_healthBar.value += amount

func _generate_loot(loot_posibilities):
	var loot = []
	var dice = RandomNumberGenerator.new()
	dice.randomize()
	for loot_option in loot_posibilities:
		if (dice.randf() < loot_option[1]):
			loot.append((loot_option[0]))
	return loot
		
func _on_Battle_Enemy_card_target():
	""" Start being a targeteable object
	"""
	get_tree().call_group("card", "get_target", self)
	print("Enable target")


func _on_Battle_Enemy_not_card_target():
	self.mouse_over = false
	get_tree().call_group("card", "get_target", false)
	print("Disable target")


func select_card():
	""" En esta función reside la inteligencia de los enemigos.
	Al llamarla, estos escogen que carta quieren jugar y la retornan.
	"""
	if deck_handler.can_play():
		var card_to_play = deck_handler.select_random_card_from_hand()
		print(self.name, " va a jugar: ", card_to_play["name"])
		return card_to_play
	return false


func _on_Battle_Enemy_playCard():
	pass # Replace with function body.
