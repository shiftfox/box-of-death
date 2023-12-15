extends CanvasLayer

@onready var animation = $AnimationPlayer

func _ready():
	animation.play_backwards("fade")

func change_scene(path: String):
	animation.play("fade")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(path)
	animation.play_backwards("fade")

func reload_scene():
	animation.play("fade")
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
	animation.play_backwards("fade")
