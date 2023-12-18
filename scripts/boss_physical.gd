extends AnimatableBody2D

@onready var health_bar = $"../../CanvasLayer/HealthBar"
@export var time: float
var health = 0
var timer: float
var enabled = false
var knocked_out = false

func _ready():
	disable()

func enable():
	show()
	position = Vector2(0, 0)
	enabled = true

func disable():
	hide()
	position = Vector2(10000, 10000)
	enabled = false
	timer = time
	knocked_out = false
	modulate = Color.WHITE

func crush(y):
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y), 0.1)
	await tween.finished
	knocked_out = true

func _process(delta):
	if not enabled: return
	timer -= delta
	if timer <= 0:
		var spot = get_node("../CircleSpot" + str(randi_range(1, 8)))
		position = spot.position - Vector2(0, 100)
		crush(spot.position.y)
		timer = time

func animate_win():
	$Area2D.queue_free()
	$"..".enabled = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2.ZERO, 1)
	tween.tween_property(self, "scale", Vector2.ZERO, 5)
	tween.parallel().tween_property(self, "modulate", Color.BLACK, 1)
	await tween.finished
	AudioManager.play_sound("stop", true)
	AudioManager.play_sound("res://audio/explosion.wav")
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0, 1, 0.5, 1)
	style_box.set_corner_radius_all(20)
	health_bar.add_theme_stylebox_override("fill", style_box)
	health_bar.value = 1
	var box = load("res://nodes/box.tscn").instantiate()
	box.position = Vector2(0, -250)
	add_sibling(box)
	$"../../Environment/Player".immune = false
	$"../../Environment/Player".camera_should_follow = true
	$"../../Setup/Camera2D".zoom = Vector2(5, 5)
	var particle = load("res://nodes/death_explosion.tscn").instantiate()
	particle.position = position
	add_sibling(particle)
	

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if knocked_out:
			health -= 0.1
			health_bar.value = health
			if health <= 0:
				animate_win()
				return
			modulate = Color.RED
			await get_tree().create_timer(0.5).timeout
			disable()
		else:
			body.damage(1, false)
