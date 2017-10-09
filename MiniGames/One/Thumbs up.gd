extends Area2D

export var velocity = Vector2()

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocity * delta)
	# If the icon hits the bottom
	if(get_pos().y >= get_viewport_rect().size.height):
		print("free")
		queue_free()
		pass 
	pass