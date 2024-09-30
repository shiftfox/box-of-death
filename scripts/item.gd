extends CharacterBody2D

var mouse_over: bool
var offset: Variant

func _physics_process(delta: float) -> void:
	if mouse_over and !offset and Input.is_action_pressed("drag"):
		offset = get_global_mouse_position() - global_position
	if Input.is_action_just_released("drag"):
		offset = null
	if offset:
		position = get_global_mouse_position() - offset
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_hitbox_mouse_entered() -> void:
	mouse_over = true

func _on_hitbox_mouse_exited() -> void:
	mouse_over = false

func interact():
	pass # TODO: spawn particles, camera shake
