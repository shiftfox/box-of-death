extends Interactable

var objects = [
	preload("res://nodes/bow.tscn"),
	preload("res://nodes/axe.tscn"),
	preload("res://nodes/stick.tscn"),
	preload("res://nodes/bucket.tscn")
]

func _interact():
	var object = objects[randi() % objects.size()].instantiate()
	object.position = global_position - Vector2(0, 20)
	object.apply_central_impulse(Vector2(0, -300))
	get_tree().current_scene.add_child(object)
