extends Area2D

@export var node: StaticBody2D
@export var interactable: Interactable
@export var enable: bool
@export var permanent: bool
@onready var default_modulate = $AlreadyPressed.modulate
var triggered = false

func _ready():
	untrigger()

func trigger():
	triggered = true
	if enable:
		node.show()
		node.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		node.hide()
		node.process_mode = Node.PROCESS_MODE_DISABLED
	if interactable: interactable.enabled = not node.visible
	$AlreadyPressed.modulate = Color.SEA_GREEN
	$AlreadyPressed.position = Vector2(0, 2)
	AudioManager.play_sound("res://audio/hitHurt.wav")

func untrigger():
	triggered = false
	if enable:
		node.hide()
		node.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		node.show()
		node.process_mode = Node.PROCESS_MODE_INHERIT
	if interactable: interactable.enabled = not node.visible
	$AlreadyPressed.modulate = default_modulate
	$AlreadyPressed.position = Vector2(0, 0)
	AudioManager.play_sound("res://audio/hitHurt.wav")

func _on_body_entered(body):
	if permanent:
		if triggered:
			untrigger()
		else:
			trigger()
	else:
		trigger()

func _on_body_exited(body):
	if permanent:
		return
	untrigger()
