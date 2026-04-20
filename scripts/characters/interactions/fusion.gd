extends CharacterBody2D

const SPEED = 250.0

var starting_position: Vector2

@onready var warrior_scene = preload("res://scenes/Player/player1.tscn")
@onready var lancer_scene  = preload("res://scenes/Player/player2.tscn")
@onready var archer_scene  = preload("res://scenes/Player/player3.tscn")


func _ready() -> void:
	starting_position = global_position


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		separate()


func separate() -> void:
	var warrior_inst = warrior_scene.instantiate()
	var lancer_inst  = lancer_scene.instantiate()
	var archer_inst  = archer_scene.instantiate()

	warrior_inst.global_position = global_position
	lancer_inst.global_position  = global_position + Vector2(-35, -20)
	archer_inst.global_position  = global_position + Vector2(35, -20)

	warrior_inst.is_active = true
	lancer_inst.is_active  = false
	archer_inst.is_active  = false

	warrior_inst.modulate.a = 1.0
	lancer_inst.modulate.a  = 0.5
	archer_inst.modulate.a  = 0.5

	var world = get_parent()
	world.add_child(warrior_inst)
	world.add_child(lancer_inst)
	world.add_child(archer_inst)

	warrior_inst.companions = [lancer_inst, archer_inst]
	lancer_inst.companions  = [warrior_inst, archer_inst]
	archer_inst.companions  = [warrior_inst, lancer_inst]

	if warrior_inst.has_node("Camera2D"):
		warrior_inst.get_node("Camera2D").make_current()

	queue_free()


func reset_to_start() -> void:
	global_position = starting_position
	velocity = Vector2.ZERO
