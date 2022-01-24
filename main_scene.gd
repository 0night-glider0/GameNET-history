extends Node2D

var member = preload("res://objects/member.tscn")

func _ready():
	$HTTPGet.request("https://gamenet-website-default-rtdb.europe-west1.firebasedatabase.app/Avatars.json")
	if OS.has_touchscreen_ui_hint():
		get_node("YSort/player/Camera2D").zoom = Vector2(0.4, 0.4)
		get_node("text/Label").text = "Используйте палец\nдля передвижения"
		get_node("text/Label2").text = "Нажмите два раза пальцем\nна коробку и перетащите"
		get_node("YSort/player/Camera2D").offset.y = -35

func _on_Button_pressed():
	OS.shell_open("https://gamejolt.com/games/lost_signal/635244")

func _on_Button2_pressed():
	OS.shell_open("https://forms.gle/zzWBmATFap6AXxUR9")

func _on_HTTPGet_request_completed(result, response_code, headers, body):
	var json = parse_json(body.get_string_from_utf8())
	for element in json:
		var new_member = member.instance()
		$YSort.add_child(new_member)
		new_member.position.x = json[element]["position_x"]
		new_member.position.y = json[element]["position_y"]
		new_member.nick = json[element]["nick"]
		new_member.area_radius = json[element]["area_radius"]
		new_member.first_message_differ = json[element]["first_message_differ"]
		new_member.ghost = json[element]["ghost"]
		new_member.messages = json[element]["messages"].split('~')
		new_member.randomize_messages = json[element]["randomize_messages"]
		new_member.run_frequency = json[element]["run_frequency"]
		new_member.speed = json[element]["speed"]
		new_member.text_speed = json[element]["text_speed"]
		new_member.modulate = json[element]["color"]
		new_member.initialize()
