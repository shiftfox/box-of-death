extends Node2D

@onready var label = $"../../CanvasLayer/Label"
@onready var player = $"../../Environment/Player"
@export var time = 20.0

var timer = 0.0
var red = 0.0
var green = 1.0

func _process(delta):
	timer += delta
	label.text = "%.1f" % (time - timer)
	label.add_theme_font_size_override("font_size", int(timer) + 75)
	
	green -= delta * .05
	red += delta * .05
	label.modulate = Color(red, green, 0.0, 1.0)
	
	if timer >= time:
		player.damage(1, false)
