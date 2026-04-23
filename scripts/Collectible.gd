extends Area2D

@export var item: InvItem

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.collect(item)
		queue_free()
