extends Node2D

export(float) var time_limit = 5
export(String, FILE, "*.tscn") var next_scene = "res://MiniGames/Five/Intro.tscn"
onready var timer = get_node("Timer")
onready var tween = get_node("Time/Tween")
var last_time = 0
const FLICKER_TIMER = 0.1
var flicker = 0
var items = [ "res://MiniGames/Four/Raygun.png", "res://MiniGames/Four/Pet1.png", "res://MiniGames/Four/Pet2.png", "res://MiniGames/Four/Sock1.png", "res://MiniGames/Four/Sock2.png" ]
var score = 0
var change_scene = null

func game_failed():
	get_node("DefeatPanel").show()
	timer.stop()
	print("FAILED")
	change_scene = "res://MiniGames/Four/Intro.tscn"

func game_passed():
	get_node("VictoryPanel").show()
	timer.stop()
	print("SUCCESS")
	change_scene = next_scene

func shuffleList(list):
    var shuffledList = []
    var indexList = range(list.size())
    for i in range(list.size()):
        randomize()
        var x = randi()%indexList.size()
        shuffledList.append(list[x])
        indexList.remove(x)
        list.remove(x)
    return shuffledList

func item_clicked(i):
	i.hide()
	score += 1
	if score == 3:
		game_passed()

func add_item(i):
	var max_items = get_node("BG/HideLocations").get_child_count()
	var found_spot = false
	while not found_spot:
		var spot = get_node("BG/HideLocations").get_child(randi() % max_items)
		if not spot.is_visible():
			spot.set_normal_texture(load(i))
			spot.connect("pressed", self, "item_clicked", [ spot ])
			spot.show()
			found_spot = true

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

func _input(event):
	if not change_scene == null:
		if((event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON) and event.pressed):
			global.goto_scene(change_scene)

func _process(delta):
	var time_left = int(timer.get_time_left())
	if not last_time == time_left:
		update_time(time_left)
	flicker += delta
	if flicker > FLICKER_TIMER:
		flicker = 0
		get_node("BG/Flash").set_opacity(rand_range(0, 0.70))

func _ready():
	items = shuffleList(items)
	for x in range(3):
		var fileCheck = File.new()
		if fileCheck.file_exists(items[x]):
			add_item(items[x])
	timer.set_wait_time(time_limit)
	timer.start()
	set_process(true)
	set_process_input(true)

func _on_Timer_timeout():
	game_failed()
