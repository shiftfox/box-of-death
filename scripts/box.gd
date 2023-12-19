extends Interactable

@export var use_limit = 0
@export var alt_objects: Array[PackedScene]
var uses = 0

var objects = [
	preload("res://nodes/bow.tscn"),
	preload("res://nodes/axe.tscn"),
	preload("res://nodes/stick.tscn"),
	preload("res://nodes/bucket.tscn")
]

var particle = preload("res://nodes/item_spawn.tscn")

func _interact():
	var object = objects[randi() % objects.size()].instantiate()
	if alt_objects.size() > 0:
		object = alt_objects[randi() % alt_objects.size()].instantiate()
	object.position = global_position - Vector2(0, 20)
	object.apply_central_impulse(Vector2(0, -300))
	add_sibling(object)
	var p = particle.instantiate()
	p.position = global_position - Vector2(0, 20)
	add_sibling(p)
	AudioManager.play_sound("res://audio/item.wav")
	
	uses += 1
	if use_limit > 0 and uses >= use_limit:
		queue_free()
