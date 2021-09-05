extends KinematicBody2D

export var nick:String = "ник"
export(Array, String, MULTILINE) var messages = ["привет"]
export var text_speed:float = 0.5
export var randomize_messages:bool = true
export var first_message_differ:bool = false
export var run_frequency:float = 0.01

export var speed:float = 30
export var area_radius:int = 100

export var ghost:bool = false


var message:String = " "  #текущие сообщение
var center = Vector2(0,0) #центр окружности патрулирования
var text_percent = 0      #скорость набора текста измеряется в процентах/кадр

var instruction = 0       #текущая инструкция
# 0 - стою на месте
# 1 - иду в какую-то точку

var target = Vector2()    #текщая точка назначения

var stop_ai = false       #тумблер отключения ИИ
var message_id = 0        #номер сообщения в списке messages

#проверка, было ли первое сообщение в списке messages показано
var check_for_first_message = false 

func pick_message():
	message = messages[message_id]
	text_percent = 1.1/float(message.length()) * text_speed
	
	message_id += 1
	
	if first_message_differ and not check_for_first_message:
		messages.pop_front()
		check_for_first_message = true
		message_id -= 1
	
	if message_id > messages.size()-1:
		message_id = 0
		if randomize_messages:
			messages.shuffle()

func first_shuffle():
	if first_message_differ:
		var buffer:String = messages.pop_front()
		messages.shuffle()
		messages.push_front(buffer)
	else:
		messages.shuffle()

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
	first_shuffle()
	pick_message()
	center = position
	
	instruction1_init()

func _process(delta):
	$nickname.text = nick
	$message.text = message
	$NinePatchRect.rect_position = $message.rect_position
	$NinePatchRect.rect_position.x -= 10
	$NinePatchRect.rect_size = $message.rect_size
	$NinePatchRect.rect_size.x += 20
	$message.percent_visible+=text_percent
	
	if not stop_ai:
		if instruction == 0:
			$AnimatedSprite.animation = "idle"
			if randf() < run_frequency:
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
	
	#ghost поведение
	if ghost:
		modulate.a = clamp( 20/position.distance_to(get_node("/root/world/YSort/player").position), 0, 1)

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$NinePatchRect.visible = true
		$message.visible = true
		$message.percent_visible = 0
		stop_ai = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		pick_message()
		$NinePatchRect.visible = false
		$message.visible = false
		stop_ai = false
