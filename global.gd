extends Node

enum {NOMATE, MARYJANE, AMILIA}

var mate_selected = NOMATE
var current_scene = null

func goto_scene(scene):
	var checkfile = File.new()
	if checkfile.file_exists(scene):
		current_scene = scene
		get_tree().change_scene(scene)
	else:
		print("ERROR: Couldn't switch to scene:",scene)

func _ready():
	pass
