extends Node

var TimeRemaining = 0
var MaximumTimeAllowed = 30
var Flame1Status = false
var Flame2Status = false
var Flame3Status = false
var Flame4Status = false
var Flame5Status = false
var Flame6Status = false
var Flame7Status = false
var MainTimer
var MainTimerLabel
var Flame1Timer
var Flame2Timer
var Flame3Timer
var Flame4Timer
var Flame5Timer
var Flame6Timer
var Flame7Timer

func ResetCandle(FlameNumber):
	if(typeof(FlameNumber) != TYPE_INT):
		return false
	
	#match FlameNumber:
	#	1: 
		

func ResetCandleTimer(FlameNumber):
	# TODO get candle timer
	
	# Pick a random extinguish time
	var MaxRemainingTime = TimeRemaining + 1
	var MaxExtinguishTime = range(1, MaxRemainingTime)[randi()%range(1, MaxRemainingTime).size()]
	
	#if FlameNumber == 1:
	
func _ready():
	#Start main timer
	MainTimer = get_node("MainTimer")
	MainTimerLabel = get_node("TimeRemaining")
	
	MainTimer.set_wait_time(MaximumTimeAllowed)
	MainTimer.connect("timeout", self, "_on_MainTimer_timeout");
	MainTimer.start()
	
func _on_Flame1_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 1 clicked")
		Flame1Status = true
		ResetCandle(1)

func _on_Flame2_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 2 clicked")
		Flame2Status = true
		ResetCandle(2)


func _on_Flame3_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 3 clicked")
		Flame3Status = true
		ResetCandle(3)


func _on_Flame4_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 4 clicked")
		Flame4Status = true
		ResetCandle(4)


func _on_Flame5_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 5 clicked")
		Flame5Status = true
		ResetCandle(5)


func _on_Flame6_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 6 clicked")
		Flame6Status = true
		ResetCandle(6)


func _on_Flame7_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Flame 7 clicked")
		Flame7Status = true
		ResetCandle(7)


func _on_MainTimer_timeout():
	pass # replace with function body
