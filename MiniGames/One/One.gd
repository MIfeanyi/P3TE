extends Node

enum STATES{RESET,CHOOSE,GAME,LOSE,SWITCH}
var girl
var strikes = 0 
var state = CHOOSE

func _ready():
	pass
	
onready var like = preload("res://MiniGames/One/Thumbs up.tscn")
onready var kiss = preload("res://MiniGames/One/Kiss.tscn")
onready var smiley = preload("res://MiniGames/One/Smiley.tscn")

func _on_Girl_pressed(string):
	girl = string
	get_node("Background/Choose").hide()
	get_node("Background/Fall").show()
	if(string == "Girl1"):
		get_node("Background/Fall/phone/Girl1").show()
		global.select_mate(global.AMILIA)
	else:
		get_node("Background/Fall/phone/Girl2").show()
		global.select_mate(global.MARYJANE)
	state = GAME
	pass
	
	if(state == GAME):
		if(!has_node("like")):
			print("loaded like")
			var l = like.instance()
			l.set_pos(Vector2(rand_range(130,200),rand_range(0,0)))
			l.set_name("like")
			add_child(l)
		pass 
		if(!has_node("kiss")):
			print("loaded kiss")
			var k = kiss.instance()
			k.set_pos(Vector2(rand_range(230,300),rand_range(0,0)))
			k.set_name("like")
			add_child(k)
		pass 
		if(!has_node("smiley")):
			print("loaded like")
			var s = smiley.instance()
			s.set_pos(Vector2(rand_range(330,400),rand_range(0,0)))
			s.set_name("smiley")
			add_child(s)
		pass 
func _reset():
	strikes = 0
	get_node("Background/Choose").show()
	state = CHOOSE