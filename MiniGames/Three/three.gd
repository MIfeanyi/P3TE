extends Node2D

export(float) var time_limit = 5
export(int) var number_of_clothes = 6
onready var timer = get_node("Timer")
onready var item = get_node("Clothes/Item")
onready var tween = get_node("Time/Tween")
var last_time = 0
var score = 0

func game_failed():
	print("FAILED")

func game_passed():
	print("SUCCESS")

func item_selected(selected):
	if not selected.is_good_item():
		game_failed()
	selected.hide()
	score += 1
	if score > 2:
		game_passed()

func add_item(sprite, good):
	var new_item = item.duplicate(true)
	get_node("Clothes").add_child(new_item)
	new_item.set_normal_texture(load(sprite))
	new_item.set_good_item(good)
	new_item.connect("pressed", self, "item_selected", [new_item])

func randomize_items():
	for child in get_node("Clothes").get_children():
		if child.is_visible():
			# TODO: Ensure no overlap
			child.set_pos(Vector2(randi() % 600 + 10, randi() % 550 + 40))

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
	add_item("res://MiniGames/Three/Pants.png", true)
	add_item("res://MiniGames/Three/Shirt.png", true)
	add_item("res://MiniGames/Three/Tie.png", true)
	add_item("res://MiniGames/Three/Beenie.png", false)
	add_item("res://MiniGames/Three/Raygun.png", false)
	add_item("res://MiniGames/Three/ClownShoes.png", false)
	randomize_items()
	timer.set_wait_time(time_limit)
	timer.start()
	set_process(true)

func _on_Timer_timeout():
	game_failed()
