extends CharacterBody2D

@onready var animation = $Animation
@export var speed: float
@export var jump_force: float
@export var coyote_time: float
var coyote_timer: float

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation.play("jump")
		coyote_timer += delta
	else:
		coyote_timer = 0
	
	var can_jump = is_on_floor() or coyote_timer < coyote_time
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -jump_force
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		$Sprite.flip_h = direction < 0
		if is_on_floor(): animation.play("walk")
	else:
		velocity.x = lerp(velocity.x, 0.0, 10 * delta)
		if is_on_floor(): animation.play("idle")
	move_and_slide()
