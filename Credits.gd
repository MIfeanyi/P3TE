extends Node2D

func _ready():
	get_node("StreamPlayer").play()
	pass

func _on_AnimationPlayer_finished():
	global.goto_scene("res://Menu.tscn")
	pass # replace with function body
