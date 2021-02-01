extends Node
#https://docs.godotengine.org/es/stable/getting_started/step_by_step/singletons_autoload.html

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	# Returning to the script, it needs to fetch the current scene in the _ready() function.
	# Both the current scene (the one with the button) and Global.gd are children of root, but autoloaded
	# nodes are always first. This means that the last child of root is always the loaded scene.


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	GameSaver.save_game()
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()
	
	# NEW by Adri.
	# Loads from save files
	#GameSaver.load_game()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
