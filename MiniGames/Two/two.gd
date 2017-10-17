extends Node2D

export(float) var time_limit = 5
export(float) var max_size = 0.75
export(String, FILE, "*.tscn") var next_scene = "res://MiniGames/Three/Intro.tscn"
onready var timer = get_node("Timer")
onready var tween = get_node("Time/Tween")
var last_time = 0
var change_scene = null
var game_started = false

func game_failed():
	get_node("DefeatPanel").show()
	timer.stop()
	print("FAILED")
	change_scene = "res://MiniGames/Two/Intro.tscn"

func game_passed():
	get_node("VictoryPanel").show()
	timer.stop()
	print("SUCCESS")
	change_scene = next_scene

func _process(delta):
	var time_left = int(timer.get_time_left())
	if not last_time == time_left:
		update_time(time_left)
	if game_started:
		var cav_visible = false
		for x in get_node("Cavities").get_children():
			if x.is_visible():
				cav_visible = true
				var tween = x.get_child(0)
				if not tween.is_active():
					x.set_disabled(true)
		if not cav_visible and not get_node("VictoryPanel").is_visible():
			timer.stop()
			game_passed()

func _input(event):
	if not change_scene == null:
		if((event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON) and event.pressed):
			global.goto_scene(change_scene)

func update_time(time_left):
	tween.interpolate_property(get_node("Time"), "rect/scale", Vector2(1.5, 1.5), Vector2(1.0, 1.0), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.interpolate_property(get_node("Time"), "rect/pos", Vector2(450, 27), Vector2(511, 27), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	var time_str = str(time_left)
	if time_left == 1:
		time_str += " Sec"
	else:
		time_str += " Secs"
	get_node("Time").set_text(time_str)
	tween.start()
	last_time = time_left

func _ready():
	var cav_tween = get_node("Cavities/Cavity/Tween")
	cav_tween.interpolate_property(get_node("Cavities/Cavity"), "rect/scale", Vector2(0.25, 0.25), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	cav_tween.start()
	var cav_tween = get_node("Cavities/Cavity1/Tween")
	cav_tween.interpolate_property(get_node("Cavities/Cavity1"), "rect/scale", Vector2(0.30, 0.30), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	cav_tween.start()
	var cav_tween = get_node("Cavities/Cavity2/Tween")
	cav_tween.interpolate_property(get_node("Cavities/Cavity2"), "rect/scale", Vector2(0.22, 0.22), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	cav_tween.start()
	var cav_tween = get_node("Cavities/Cavity3/Tween")
	cav_tween.interpolate_property(get_node("Cavities/Cavity3"), "rect/scale", Vector2(0.27, 0.27), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	cav_tween.start()
	var cav_tween = get_node("Cavities/Cavity4/Tween")
	cav_tween.interpolate_property(get_node("Cavities/Cavity4"), "rect/scale", Vector2(0.36, 0.36), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	cav_tween.start()
#	var cav_tween = get_node("Cavities/Cavity5/Tween")
#	cav_tween.interpolate_property(get_node("Cavities/Cavity5"), "rect/scale", Vector2(0.25, 0.25), Vector2(max_size, max_size), time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	cav_tween.start()
	timer.set_wait_time(time_limit)
	timer.start()
	set_process(true)
	set_process_input(true)
	game_started = true

func _on_Cavity_pressed():
	get_node("Cavities/Cavity").hide()

func _on_Timer_timeout():
	var success = true
	for x in get_node("Cavities").get_children():
		if x.is_visible():
			success = false
	if success:
		game_passed()
	else:
		game_failed()


func _on_Cavity1_pressed():
	get_node("Cavities/Cavity1").hide()


func _on_Cavity2_pressed():
	get_node("Cavities/Cavity2").hide()


func _on_Cavity4_pressed():
	get_node("Cavities/Cavity4").hide()

func _on_Cavity3_pressed():
	get_node("Cavities/Cavity3").hide()
