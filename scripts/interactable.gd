extends RigidBody2D
class_name Interactable

var mouse_in = false
var dragging = false
var offset = Vector2.ZERO

func _ready():
	mouse_entered.connect(Callable(self, "_on_mouse_entered"))
	mouse_exited.connect(Callable(self, "_on_mouse_exited"))

func _interact():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("drag") and mouse_in:
		freeze = true
		dragging = true
		offset = global_position - get_global_mouse_position()

	if Input.is_action_just_pressed("interact") and mouse_in:
		_interact()

	if dragging:
		global_transform.origin = get_global_mouse_position() + offset

	if Input.is_action_just_released("drag"):
		dragging = false
		freeze = false

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
