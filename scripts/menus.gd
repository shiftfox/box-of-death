extends CanvasLayer

@export var active: Control
func toggle(new_control):
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
