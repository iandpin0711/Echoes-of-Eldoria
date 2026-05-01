extends Area2D
@onready var textbox = $"../Textbox"

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.in_zone = true
		textbox.show_text("Press E to enter to the castle.")

func _on_body_exited(body):
	if body is CharacterBody2D:
		body.in_zone = false
		textbox.hide_textbox()
