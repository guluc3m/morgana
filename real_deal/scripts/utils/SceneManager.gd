extends Node
#https://docs.godotengine.org/es/stable/getting_started/step_by_step/singletons_autoload.html

var current_scene = null
var previous_scene = null


func _ready():
	var root = get_tree().get_root()
	self.current_scene = root.get_child(root.get_child_count() - 1)
	# Returning to the script, it needs to fetch the current scene in the _ready() function.
	# Both the current scene (the one with the button) and Global.gd are children of root, but autoloaded
	# nodes are always first. This means that the last child of root is always the loaded scene.


func goto_scene(path, data, can_go_back=false):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	# GameSaver.save_game()
	# NO guardamos datos porque solo guardaremos cuando el usuario cierre el juego
	# Y cuando estén en zonas concretas
	call_deferred("_deferred_goto_scene", path, data, can_go_back)


func _deferred_goto_scene(scene, data, can_go_back):
	if can_go_back:
		self.previous_scene = self.current_scene
		
	get_tree().get_root().remove_child(self.current_scene)

	# Se pasa ruta a al escena
	if typeof(scene) == TYPE_STRING:
		var s = ResourceLoader.load(scene)
		# Instance the new scene.
		self.current_scene = s.instance()
	else:
		# Se pasa una instancia de escena
		self.current_scene = scene

	get_tree().get_root().add_child(self.current_scene)
	get_tree().set_current_scene(self.current_scene)
	if data:
		self.current_scene.update_data(data)
