extends Node2D

export(float) var time_limit = 5
onready var timer = get_node("Timer")
onready var tween = get_node("Time/Tween")
var last_time = 0

func game_failed():
	print("FAILED")

func game_passed():
	print("SUCCESS")

func update_time(time_left):
	tween.interpolate_property(get_node("Time"), "rect/scale", Vector2(1.5, 1.5), Vector2(1.0, 1.0), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.interpolate_property(get_node("Time"), "rect/pos", Vector2(450, 32), Vector2(511, 32), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	var time_str = str(time_left)
	if time_left == 1:
		time_str += " Sec"
	else:
		time_str += " Secs"
	get_node("Time").set_text(time_str)
	tween.start()
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
