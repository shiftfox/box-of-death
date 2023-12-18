extends Node2D

@export var time: float
var spawn_circles = false
var kill_circle = preload("res://nodes/kill_circle.tscn")
var temporary = preload("res://nodes/temporary.tscn")
var timer = time
var enabled = true

func attack():
	$PhysicalForm.disable()
	await get_tree().create_timer(1).timeout
	for i in range(3):
		var circles = []
		for j in range(3):
			var spot = get_node("CircleSpot" + str(randi_range(1, get_child_count() - 1)))
			var temp = temporary.instantiate()
			spot.add_child(temp)
			await get_tree().create_timer(0.5).timeout
			temp.queue_free()
			var circle = kill_circle.instantiate()
			spot.add_child(circle)
			circles.append(circle)
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(1).timeout
		for circle in circles:
			circle.queue_free()
		await get_tree().create_timer(0.5).timeout

func _process(delta):
	if not enabled: return
	timer -= delta
	if timer <= 0:
		spawn_circles = not spawn_circles
		if spawn_circles:
			attack()
		else:
			$PhysicalForm.enable()
		timer = time
