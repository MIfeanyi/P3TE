extends Control

export(float) var transition_time = 3.0 # Transition timer setting
export(String, FILE, "*.tscn") var minigame = "res://MiniGames/Four/four.tscn"
onready var timer = get_node("Timer")

func start_game():
	var checkfile = File.new()
	if checkfile.file_exists(minigame):
		get_tree().change_scene(minigame)
	else:
		print("Error: Minigame scene could not be loaded")

func _input(event):
	if(event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON):
		start_game()

func _ready():
	timer.set_wait_time(transition_time)
	timer.start()
	set_process_input(true)

func _on_Timer_timeout():
	start_game()
