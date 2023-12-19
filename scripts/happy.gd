extends Interactable

var bullet = preload("res://nodes/paint.tscn")

func _ready():
	super._ready()
	modulate = Color(randf(), randf(), randf(), 1)

func _interact():
	AudioManager.play_sound("res://audio/explosion.wav")
	for i in range(50):
		var projectile = bullet.instantiate()
		projectile.position = global_position
		projectile.modulate = modulate
		projectile.apply_impulse(Vector2(randf_range(-250, 250), randf_range(-250, 250)))
		call_deferred("add_sibling", projectile)
	queue_free()
