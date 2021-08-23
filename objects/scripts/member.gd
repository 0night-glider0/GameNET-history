extends KinematicBody2D

export var nick:String = "ник"
export(String, MULTILINE) var message:String = "сообщение"


export var speed:float = 30
export var area_radius:int = 100

var center = Vector2(0,0)

var instruction = 0

var target = Vector2()

var stop_ai = false

func instruction0_init():
	instruction = 0

func instruction1_init():
	instruction = 1
	var angle = rand_range(0, 2*PI)
	var r = rand_range(0, area_radius)
	target = center + Vector2(r, 0).rotated(angle)

func move_to_point():
	var move_vec = Vector2(-speed, 0).rotated(position.angle_to_point(target))
	if position.distance_to(target) < 10:
		instruction0_init()
	var test = move_and_slide(move_vec)
	if test.length() < speed/3:
		instruction0_init()

func _ready():
	center = position
	instruction1_init()

func _process(delta):
	$nickname.text = nick
	$message.text = message
	$NinePatchRect.rect_position = $message.rect_position
	$NinePatchRect.rect_position.x -= 10
	$NinePatchRect.rect_size = $message.rect_size
	$NinePatchRect.rect_size.x += 20
	$message.percent_visible+=0.01
	if not stop_ai:
		
		if instruction == 0:
			$AnimatedSprite.animation = "idle"
			if randf() < 0.01:
				instruction1_init()
				
		if instruction == 1:
			$AnimatedSprite.animation = "walk"
			if target.x - position.x > 0:
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true
			move_to_point()
	else:
		$AnimatedSprite.animation = "idle"
	
	

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$NinePatchRect.visible = true
		$message.visible = true
		$message.percent_visible = 0
		stop_ai = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$NinePatchRect.visible = false
		$message.visible = false
		stop_ai = false
