extends KinematicBody2D

export var speed:float = 60

var can_move = true

func _process(delta):
	var move = Vector2()
	
	if can_move:
		if Input.is_action_pressed("move_left"):
			move.x = -1
			$AnimatedSprite.flip_h = true
		if Input.is_action_pressed("move_right"):
			move.x = 1
			$AnimatedSprite.flip_h = false
		
		if Input.is_action_pressed("move_up"):
			move.y = -1
		if Input.is_action_pressed("move_down"):
			move.y = 1
		
		if OS.has_touchscreen_ui_hint():
			if Input.is_action_pressed("throw"):
				move = ( get_global_mouse_position() - position ).normalized()
		
		move = move.normalized()
	
	
	if move == Vector2.ZERO:
		$AnimatedSprite.animation = "idle"
	else:
		$AnimatedSprite.animation = "walk"
	
	move_and_slide(move * speed)
