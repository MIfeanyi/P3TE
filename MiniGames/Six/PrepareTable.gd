extends Node

onready var tween = get_node("TimeRemaining/Tween")
export(String, FILE, "*.tscn") var next_scene = "res://MiniGames/Seven/Intro.tscn"

var TimeRemaining = 0
var MaximumTimeAllowed = 30
var MainTimer
var MainTimerLabel
var Flame1Timer
var Flame2Timer
var Flame3Timer
var Flame4Timer
var Flame5Timer
var Flame6Timer
var Flame7Timer
var last_time = 0
var change_scene = null

func game_failed():
	get_node("DefeatPanel").show()
	get_node("MainTimer").stop()
	print("FAILED")
	change_scene = "res://MiniGames/Six/Intro.tscn"

func game_passed():
	get_node("VictoryPanel").show()
	get_node("MainTimer").stop()
	print("SUCCESS")
	change_scene = next_scene


func ResetCandle(FlameNumber):
	if(typeof(FlameNumber) != TYPE_INT):
		return false
	
	if FlameNumber == 1:
		ResetCandleTimer(1)
	elif FlameNumber == 2:
		ResetCandleTimer(2)
	elif FlameNumber == 3:
		ResetCandleTimer(3)
	elif FlameNumber == 4:
		ResetCandleTimer(4)
	elif FlameNumber == 5:
		ResetCandleTimer(5)
	elif FlameNumber == 6:
		ResetCandleTimer(6)
	elif FlameNumber == 7:
		ResetCandleTimer(7)
	else:
		return false

func ResetCandleTimer(FlameNumber):
	# Pick a random extinguish time based on remaining time + 1 second
	var MaxRemainingTime = MainTimer.get_time_left() + 1
	var MaxExtinguishTime = range(1, MaxRemainingTime)[randi()%range(1, MaxRemainingTime).size()]
	print("New timeout for the Extinguish timer is " + str(MaxExtinguishTime) + " seconds");
	
	get_node("Flame"+str(FlameNumber)+"/Flame").show()
	
	var FlameTimerNodeRef = "Flame" + str(FlameNumber) + "Timer"
	var FlameTimer = get_node(FlameTimerNodeRef)
	FlameTimer.set_wait_time(MaxExtinguishTime)
	FlameTimer.connect("timeout", self, "_on_"+str(FlameTimerNodeRef)+"_timeout")
	print("Resetting Timer for Flame" + str(FlameNumber) + "Timer")
	FlameTimer.start()
	
func CheckIfCandlesAreLit():
	var Candle1Lit = get_node("Flame1/Flame").is_hidden()
	var Candle2Lit = get_node("Flame2/Flame").is_hidden()
	var Candle3Lit = get_node("Flame3/Flame").is_hidden()
	var Candle4Lit = get_node("Flame4/Flame").is_hidden()
	var Candle5Lit = get_node("Flame5/Flame").is_hidden()
	var Candle6Lit = get_node("Flame6/Flame").is_hidden()
	var Candle7Lit = get_node("Flame7/Flame").is_hidden()
	
	if (Candle1Lit == false and Candle2Lit == false and Candle3Lit == false and Candle4Lit == false and Candle5Lit == false and Candle6Lit == false and Candle7Lit == false):
		# They've completed this minigame
		print("Minigame completed")
		# Stop All Timers (this won't matter in practice but does for development)
		get_node("MainTimer").stop();
		get_node("Flame1Timer").stop();
		get_node("Flame2Timer").stop();
		get_node("Flame3Timer").stop();
		get_node("Flame4Timer").stop();
		get_node("Flame5Timer").stop();
		get_node("Flame6Timer").stop();
		get_node("Flame7Timer").stop();
		game_passed()
	else:
		# Still haven't completed it
		print("Minigame not completed")
#		game_failed()
	 
func _ready():
	randomize()
	
	#Start main timer
	MainTimer = get_node("MainTimer")
	MainTimerLabel = get_node("TimeRemaining")
	
	MainTimer.set_wait_time(MaximumTimeAllowed)
	MainTimer.connect("timeout", self, "_on_MainTimer_timeout")
	print("Starting Main Timer")
	MainTimer.start()
	set_process(true)
	set_process_input(true)

func update_time(time_left):
	tween.interpolate_property(get_node("TimeRemaining"), "rect/scale", Vector2(1.5, 1.5), Vector2(1.0, 1.0), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.interpolate_property(get_node("TimeRemaining"), "rect/pos", Vector2(180, 11), Vector2(248, 11), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	var time_str = str(time_left)
	if time_left == 1:
		time_str += " Sec"
	else:
		time_str += " Secs"
	get_node("TimeRemaining").set_text(time_str)
	tween.start()
	last_time = time_left

# Native Godot Methods

func _process(delta):
	var time_left = int(MainTimer.get_time_left())
	if not last_time == time_left:
		update_time(time_left)

func _input(event):
	if not change_scene == null:
		if((event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON) and event.pressed):
			global.goto_scene(change_scene)


func _on_Flame1_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 1 clicked")
		ResetCandle(1)
		CheckIfCandlesAreLit()

func _on_Flame2_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 2 clicked")
		ResetCandle(2)
		CheckIfCandlesAreLit()


func _on_Flame3_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 3 clicked")
		ResetCandle(3)
		CheckIfCandlesAreLit()


func _on_Flame4_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 4 clicked")
		ResetCandle(4)
		CheckIfCandlesAreLit()


func _on_Flame5_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 5 clicked")
		ResetCandle(5)
		CheckIfCandlesAreLit()

func _on_Flame6_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 6 clicked")
		ResetCandle(6)
		CheckIfCandlesAreLit()


func _on_Flame7_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 7 clicked")
		ResetCandle(7)
		CheckIfCandlesAreLit()

func _on_MainTimer_timeout():
	# If the player ever gets here they didn't win so we have to rack up a loss.\
	game_failed()
	# Transition to next game (TODO by other developers)


func _on_Flame1Timer_timeout():
	print("Flame 1 is dead")
	get_node("Flame1/Flame").hide()
	get_node("Flame1Timer").stop()


func _on_Flame2Timer_timeout():
	print("Flame 2 is dead")
	get_node("Flame2/Flame").hide()
	get_node("Flame2Timer").stop()


func _on_Flame3Timer_timeout():
	print("Flame 3 is dead")
	get_node("Flame3/Flame").hide()
	get_node("Flame3Timer").stop()


func _on_Flame4Timer_timeout():
	print("Flame 4 is dead")
	get_node("Flame4/Flame").hide()
	get_node("Flame4Timer").stop()


func _on_Flame5Timer_timeout():
	print("Flame 5 is dead")
	get_node("Flame5/Flame").hide()
	get_node("Flame5Timer").stop()


func _on_Flame6Timer_timeout():
	print("Flame 6 is dead")
	get_node("Flame6/Flame").hide()
	get_node("Flame6Timer").stop()


func _on_Flame7Timer_timeout():
	print("Flame 7 is dead")
	get_node("Flame7/Flame").hide()
	get_node("Flame7Timer").stop()
