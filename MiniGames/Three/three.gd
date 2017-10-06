extends Node2D

export(float) var time_limit = 5
export(int) var number_of_clothes = 6
onready var timer = get_node("Timer")
onready var item = get_node("Clothes/Item")
var last_time = 0

func game_failed():
	pass

func game_passed():
	pass

func update_time(time_left):
	# Optional could make time bounce or move for each second changed
	var time_str = str(time_left)
	if time_left == 1:
		time_str += " Sec"
	else:
		time_str += " Secs"
	get_node("Time").set_text(time_str)
	last_time = time_left

func _process(delta):
	var time_left = int(timer.get_time_left())
	if not last_time == time_left:
		update_time(time_left)

func _ready():
	timer.set_wait_time(time_limit)
	timer.start()
	set_process(true)

func _on_Timer_timeout():
	game_failed()
