extends Label



func _process(delta):
	percent_visible+=0.01
	if percent_visible >= 1:
		percent_visible = 0
