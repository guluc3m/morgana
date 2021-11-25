extends Node

var floating_text = preload("res://real_deal/scenes/utils/FloatingText.tscn")
# MIGRAR A UI script
func draw_text(draw, color=[0,0,0]):
	""" Draw the text over the character sprite
	"""
	var text = floating_text.instance()
	
	text.text = draw
	text.color = color
	add_child(text)

	# Aquí se dibuja el daño, rojo si es daño, verde si es positivo
func modify_health(amount):
	if amount >= 0:
		self.draw_text(amount, [0,255,0])
	else:
		self.draw_text(abs(amount), [255,0,0])


func set_armor(amount):
	# Aquí se dibuja la armadura obtenida en color amarillo-marrón
	self.draw_text(abs(amount), [226,185,0])
###
