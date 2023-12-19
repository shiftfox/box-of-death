extends Control

func _ready():
	var index = 1
	for button in get_children():
		button.pressed.connect(func():
			AudioManager.play_sound("res://audio/select.wav")
			if button.name == "thanks":
				SceneManager.change_scene("res://scenes/thanks.tscn")
				return
			SceneManager.change_scene("res://scenes/level_" + str(index) + ".tscn")
		)
		index += 1
