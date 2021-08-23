extends NinePatchRect

func _process(delta):
	if get_parent().stop_ai:
		visible = false
	else:
		visible = true
	$Label.percent_visible+=0.01
	if $Label.percent_visible >= 1:
		$Label.percent_visible = 0
