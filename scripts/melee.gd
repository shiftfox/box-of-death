extends Interactable

@export var damage = 0.1

func _on_body_entered(body):
	if body.name == "Player":
		body.damage(damage, true)
		queue_free()
