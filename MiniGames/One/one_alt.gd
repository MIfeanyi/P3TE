extends Node2D

# Do to lack of time we only had two people to pick from.
# When other genders, races, and interesting people get added
# this will need to be expanded to match
export(String, FILE, "*.tscn") var next_scene = "res://MiniGames/Two/Intro.tscn"
var ppl = [ ]
var falling_items = []

var selected = global.MARYJANE

var game_started = false
var total_right = 0
var total_wrong = 0
var sent = 0
var current_scene = null

func add_right():
	total_right += 1
	print("Good")
	if total_right > 4:
		get_node("VictoryPanel").show()
		current_scene = next_scene

func add_wrong():
	print("Missed")
	total_wrong += 1
	if total_wrong > 2:
		get_node("DefeatPanel").show()
		current_scene = "res://MiniGames/One/Intro.tscn"
#
func set_next_timer():
	get_node("LikeTimer").stop()
	get_node("LoveTimer").stop()
	get_node("StarTimer").stop()
	
	randomize()
	var next = floor(rand_range(0,3)) # generate rand num from 0-2
	print(next)
	if next == 0:
		get_node("LikeTimer").set_wait_time(rand_range(1, 3))
		get_node("LikeTimer").start()
	if next == 1:
		get_node("LoveTimer").set_wait_time(rand_range(1, 3))
		get_node("LoveTimer").start()
	if next == 2:
		get_node("StarTimer").set_wait_time(rand_range(1, 3))
		get_node("StarTimer").start()

	
func enable_game_screen():
	get_node("BG/Select").hide()
	get_node("BG/LeftButton").hide()
	get_node("BG/RightButton").hide()
	get_node("BG/Panel").show()
	set_next_timer()
#	get_node("LikeTimer").set_wait_time(rand_range(0.5, 3))
#	get_node("LikeTimer").start()
#	get_node("LoveTimer").set_wait_time(rand_range(0.5, 3))
#	get_node("LoveTimer").start()
#	get_node("StarTimer").set_wait_time(rand_range(0.5, 3))
#	get_node("StarTimer").start()

func _input(event):
	if not current_scene == null:
		if((event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON) and event.pressed):
			global.goto_scene(current_scene)

func _process(delta):
	if game_started and falling_items.size() > 0:
		for x in falling_items:
			if not x.get_child(0).is_active():
				x.hide()
				falling_items.remove(x)

func _ready():
	ppl.append(load("res://RawAssets/Sketches/mary_jane.png"))
	ppl.append(load("res://RawAssets/Sketches/Amilia.png"))
	set_process(true)
	set_process_input(true)

func _on_Select_pressed():
	global.mate_selected = selected
	game_started = true
	enable_game_screen()

func _on_LeftButton_pressed():
	if selected == global.MARYJANE:
		selected = global.AMILIA
		get_node("BG/Pic").set_normal_texture(ppl[1])
	else:
		selected = global.MARYJANE
		get_node("BG/Pic").set_normal_texture(ppl[0])


func _on_RightButton_pressed():
	_on_LeftButton_pressed() # Since with 2 ppl it doesn't matter

func _on_Like_pressed():
	set_next_timer()
	var found = false
	for x in falling_items:
		if x.get_pos().y > 400 and x.get_pos().y < 450:
			if x.get_pos().x == 215:
				found = true
	if found:
		add_right()
	else:
		add_wrong()

func _on_Love_pressed():
	set_next_timer()
	var found = false
	for x in falling_items:
		if x.get_pos().y > 400 and x.get_pos().y < 450:
			if x.get_pos().x == 290:
				found = true
	if found:
		add_right()
	else:
		add_wrong()

func _on_Star_pressed():
	set_next_timer()
	var found = false
	for x in falling_items:
		if x.get_pos().y > 400 and x.get_pos().y < 450:
			if x.get_pos().x == 370:
				found = true
	if found:
		add_right()
	else:
		add_wrong()

func _on_LikeTimer_timeout():
	var like = get_node("BG/LikeFall").duplicate(true)
	get_node("BG").add_child(like)
	get_node("BG").move_child(like, 2)
	like.show()
	var tween = like.get_child(0)	
	tween.interpolate_property(like, "transform/pos", like.get_pos(), like.get_pos() + Vector2(0,380), 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	falling_items.append(like)
	if sent > 6:
		get_node("LikeTimer").set_wait_time(rand_range(1, 3))
		get_node("LikeTimer").start()

func _on_LoveTimer_timeout():
	sent += 1
	var like = get_node("BG/LoveFall").duplicate(true)
	get_node("BG").add_child(like)
	get_node("BG").move_child(like, 2)
	like.show()
	var tween = like.get_child(0)	
	tween.interpolate_property(like, "transform/pos", like.get_pos(), like.get_pos() + Vector2(0,380), 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	falling_items.append(like)
	if sent < 6:
		get_node("LoveTimer").set_wait_time(rand_range(1, 3))
		get_node("LoveTimer").start()

func _on_StarTimer_timeout():
	sent += 1
	var like = get_node("BG/StarFall").duplicate(true)
	get_node("BG").add_child(like)
	get_node("BG").move_child(like, 2)
	like.show()
	var tween = like.get_child(0)	
	tween.interpolate_property(like, "transform/pos", like.get_pos(), like.get_pos() + Vector2(0,380), 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	falling_items.append(like)
	if sent < 6:
		get_node("StarTimer").set_wait_time(rand_range(1, 3))
		get_node("StarTimer").start()
