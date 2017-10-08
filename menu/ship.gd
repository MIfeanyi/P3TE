extends AnimationPlayer

func _ready():
	pass

func _on_AnimationPlayer_finished():
	queue("Float2")
	queue("Float1")
	pass # replace with function body
