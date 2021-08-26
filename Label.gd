extends Label

export (String, MULTILINE) var mobile_text = "text_mobile"

func _ready():
	if OS.has_touchscreen_ui_hint():
		text = mobile_text
