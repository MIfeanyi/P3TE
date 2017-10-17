extends Node

export(String, FILE, "*.tscn") var StartScene = "res://MiniGames/One/Intro.tscn"

func _ready():
	pass

func _on_Button_pressed():
	global.goto_scene(StartScene)
