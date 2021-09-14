extends KinematicBody2D

var rotate_direction = 0
var speed = Vector2()
var rotate_speed = 0

func _ready():
	rotate_direction = sign(rand_range( -100, 100))
	add_to_group("throwable")

func _process(delta):
	speed*=0.95
	rotation_degrees+=rotate_speed
	speed = move_and_slide(speed, Vector2(), false, 4, 0.7, true)
	rotate_speed = speed.length() * rotate_direction * 0.05
