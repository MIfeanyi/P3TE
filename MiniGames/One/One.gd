extends Node

enum STATES {RESET,CHOOSE,GAME,LOSE,SWITCH}
var girl
var strikes = 0 
var state = CHOOSE
func _ready():
	pass

func _on_Girl_pressed(string):
	girl = string
	get_node("Background/Choose").hide()
	get_node("Background/Fall").show()
	if(string == "Girl1"):
		get_node("Background/Fall/phone/Girl1").show()
	else:
		get_node("Background/Fall/phone/Girl2").show()
	state = GAME
	pass 

func _reset():
	strikes = 0
	get_node("Background/Choose").show()
	state = CHOOSE