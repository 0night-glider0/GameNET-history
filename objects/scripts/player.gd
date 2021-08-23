extends KinematicBody2D

export var speed:float = 60


func _process(delta):
	
	var move = Vector2()
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
	
	if move == Vector2():
		$AnimatedSprite.animation = "idle"
	else:
		$AnimatedSprite.animation = "walk"
	
	move_and_slide(move * speed)
