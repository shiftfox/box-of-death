extends CanvasLayer

@export var active: Control

func _ready():
	AudioManager.play_sound("res://audio/menus.mp3", true)

func toggle(new_control):
	AudioManager.play_sound("res://audio/select.wav")	
	var tween = get_tree().create_tween()
	if active:
		tween.tween_property(active, "modulate", Color.TRANSPARENT, 0.3)
		await tween.finished
		active.hide()
		tween = get_tree().create_tween()
	
	active = new_control
	active.show()
	tween.tween_property(active, "modulate", Color.WHITE, 0.3)

func _settings():
	toggle($Settings)

func _play():
	toggle($LevelSelect)

func _quit():
	get_tree().quit()

func _back():
	toggle($MainMenu)
