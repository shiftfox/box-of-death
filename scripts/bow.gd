extends Interactable

var bullet = preload("res://nodes/arrow.tscn")
var shot = 0

func _ready():
	super._ready()

func _interact():
	var arrow = bullet.instantiate()
	arrow.position = $FirePoint.global_position
	arrow.rotation = global_rotation
	arrow.set_linear_velocity(Vector2(cos(rotation), sin(rotation)) * 250)
	get_tree().current_scene.add_child(arrow)
	shot += 1
	if shot >= 5:
		queue_free()
