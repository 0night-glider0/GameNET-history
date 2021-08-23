extends Area2D

var instances = []
var current_box = self
var current_box_vector = Vector2()

func _process(delta):
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("throw"):
		instances = get_overlapping_bodies()
		for element in instances:
			if element.is_in_group("throwable"):
				current_box = element
	
	if Input.is_action_just_released("throw"):
		current_box = self
		
	if Input.is_action_pressed("throw"):
		if current_box != self:
			current_box.speed.x += (position.x - current_box.position.x) / 2
			current_box.speed.y += (position.y - current_box.position.y) / 2
			
