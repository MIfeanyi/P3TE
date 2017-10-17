extends TextureButton

var good_item = false

func is_good_item():
	return good_item

func set_good_item(b):
	good_item = b

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
