extends Control


func _process(delta):
	if Input.is_action_pressed("throw"):
		$Label.text = "-Вань, а ты знал что мы \nможем сделать свой кружок?"
