extends Node2D

signal next_stage_picked()

@export var stage_count: int
@export var health: float
@onready var health_bar = $"../../CanvasLayer/BossHealthBar"
@onready var stage_timer = $StageTimer
var stage = 0

# STAGE 0
var kill_circle_preview = preload("res://nodes/preview.tscn")
var kill_circle = preload("res://nodes/kill_circle.tscn")

# STAGE 1
var objects = [
	preload("res://nodes/axe.tscn"),
	preload("res://nodes/stick.tscn"),
]

# STAGE 2
var can_damage = false
var box = preload("res://nodes/box.tscn")

# PARTICLES
var explosion_particle = preload("res://nodes/death_explosion.tscn")
var small_explosion = preload("res://nodes/damage_explosion.tscn")

func spawn_particle(pos: Vector2, particle: PackedScene):
	var p = particle.instantiate()
	p.position = pos
	p.emitting = true
	call_deferred("add_sibling", p)

func get_random_location():
	var start = $"StartLocation".position
	var end = $"EndLocation".position
	return Vector2(randf_range(start.x, end.x), randf_range(start.y, end.y))

func timeout(time: float):
	return get_tree().create_timer(time).timeout

func stage_0():
	for i in range(5):
		var circles = []
		AudioManager.play_sound("res://audio/hitHurt.wav")
		for j in range(5):
			var circle = kill_circle_preview.instantiate()
			circle.position = get_random_location()
			circles.append(circle)
			call_deferred("add_sibling", circle)
		
		await timeout(1.5)
		AudioManager.play_sound("res://audio/spawn.wav")
		for circle in circles:
			circle.queue_free()
			var c = kill_circle.instantiate()
			c.position = circle.position
			circles[circles.find(circle)] = c
			call_deferred("add_sibling", c)
			spawn_particle(circle.position, small_explosion)

		await timeout(0.5)
		for circle in circles: circle.queue_free()

func stage_1():
	var objs = []
	for i in range(9):
		AudioManager.play_sound("res://audio/spawn.wav")
		var object = objects[randi() % objects.size()].instantiate()
		object.position = get_random_location() - Vector2(0, 185)
		object.freeze = true
		objs.append(object)
		call_deferred("add_sibling", object)
		await timeout(1)
		object.freeze = false
	
	await timeout(1)
	for object in objs: 
		if is_instance_valid(object):
			object.queue_free()

func stage_2():
	var tween = get_tree().create_tween()
	var location = get_random_location()
	tween.tween_property(self, "position", location - Vector2(0, 100), 1)
	tween.tween_property(self, "rotation", deg_to_rad(45), 1)
	tween.tween_property(self, "position", location - Vector2(0, 120), 1)
	tween.tween_property(self, "position", location, 0.1)
	
	await tween.finished
	can_damage = true
	AudioManager.play_sound("res://audio/hitHurt.wav")
	
	await next_stage_picked
	can_damage = false
	position = Vector2(350, -68)

func pick_new_stage():
	stage = randi_range(0, stage_count)
	match stage:
		0: stage_timer.wait_time = 10
		1: stage_timer.wait_time = 10
		2: stage_timer.wait_time = 15
	call("stage_%d" % stage)
	stage_timer.start(stage_timer.wait_time)
	next_stage_picked.emit()

func finished():
	stage_timer.stop()
	AudioManager.play_sound("stop", true)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, -50), 1)
	tween.parallel().tween_property(health_bar, "modulate", Color.TRANSPARENT, 1)
	tween.parallel().tween_property(self, "rotation", deg_to_rad(-1000), 5)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO, 5)
	tween.parallel().tween_property(self, "modulate", Color.BLACK, 5)
	
	await tween.finished
	AudioManager.play_sound("res://audio/explosion.wav")
	spawn_particle(position, explosion_particle)
	
	var b = box.instantiate()
	b.position = position
	call_deferred("add_sibling", b)
	
	$"../Player".boss_dead = true
	$"../Player".camera_should_follow = true
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_property($"../../Setup/Camera2D", "zoom", Vector2(5, 5), 1).set_trans(Tween.TRANS_SINE)
	
	queue_free()

func _ready():
	health_bar.max_value = health
	health_bar.value = health
	await timeout(3)
	pick_new_stage()

func body_entered(body):
	if body.name == "Player":
		if can_damage:
			AudioManager.play_sound("res://audio/explosion.wav")
			spawn_particle(position, explosion_particle)
			health -= 1
			health_bar.value = health
			if health <= 0:
				finished()
				return
			stage_timer.stop()
			pick_new_stage()
		else:
			body.damage(1, false)
