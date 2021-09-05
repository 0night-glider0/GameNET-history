extends Node2D

func _ready():
	if OS.has_touchscreen_ui_hint():
		get_node("YSort/player/Camera2D").zoom = Vector2(0.4, 0.4)
		get_node("text/Label").text = "Используйте палец\nдля передвижения"
		get_node("text/Label2").text = "Нажмите два раза пальцем\nна коробку и перетащите"

func _on_Button_pressed():
	OS.shell_open("https://gamejolt.com/games/lost_signal/635244")

func _on_Button2_pressed():
	OS.shell_open("https://forms.gle/zzWBmATFap6AXxUR9")
