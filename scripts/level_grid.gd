extends Control

func _ready():
	var index = 1
	for button in get_children():
		button.pressed.connect(func(): SceneManager.change_scene("res://scenes/level_" + str(index) + ".tscn"))
		index += 1
