extends Interactable

var color: Color
var shooting = false
var bullet = preload("res://nodes/paint.tscn")
var time = 0.1
var timer = 0

func _ready():
	super._ready()
	color = Color(randf(), randf(), randf(), 1)
	$Paint.modulate = color

func _process(delta):
	super._process(delta)
	if not shooting: return
	
	timer += delta
	if timer >= time:
		var paint = bullet.instantiate()
		paint.position = $FirePoint.global_position
		paint.rotation = global_rotation
		paint.modulate = color
		paint.set_linear_velocity(Vector2(cos(rotation), sin(rotation)) * 250)
		get_tree().current_scene.add_child(paint)
		timer = 0

func _interact():
	shooting = true
	AudioManager.play_sound("res://audio/bucket.wav")
	var tween = get_tree().create_tween()
	tween.tween_property($Paint, "modulate", Color.TRANSPARENT, 1)
	await tween.finished
	queue_free()
