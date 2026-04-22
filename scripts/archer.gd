extends Area2D

var direction = Vector2.RIGHT
var vel = Vector2.ZERO
var initialized = false
var timer = 0.0
const SPEED = 400.0
const GRAVITY = 150.0


func _physics_process(delta):
	if not initialized:
		print("direction: ", direction)
		vel = direction.normalized() * SPEED
		rotation = vel.angle()
		initialized = true
		
	timer += delta
	if timer >= 2.0:
		queue_free()
		return

	vel.y += GRAVITY * delta
	position += vel * delta
	rotation = vel.angle()
