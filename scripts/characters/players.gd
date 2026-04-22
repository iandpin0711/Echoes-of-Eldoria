extends CharacterBody2D

const SPEED = 250.0

var is_active: bool = false
var starting_position: Vector2
var companions: Array = []

# Estado de fight para no repetir el ataque
var _is_fighting: bool = false


func _ready() -> void:
	starting_position = global_position


func _physics_process(delta: float) -> void:
	if not is_active:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	_handle_fight()
	_handle_animations(direction)
	_handle_switch_input()


func _handle_fight() -> void:
	if Input.is_action_just_pressed("fight") and not _is_fighting:
		_is_fighting = true
		$AnimatedSprite2D.play("fight")
		# Conecta la señal solo una vez para saber cuándo termina
		if not $AnimatedSprite2D.animation_finished.is_connected(_on_fight_finished):
			$AnimatedSprite2D.animation_finished.connect(_on_fight_finished)


func _on_fight_finished() -> void:
	_is_fighting = false
	$AnimatedSprite2D.animation_finished.disconnect(_on_fight_finished)


func _handle_animations(direction: float) -> void:
	if _is_fighting:
		return  # El fight tiene prioridad, no interrumpir
	if direction != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")


func _handle_switch_input() -> void:
	if Input.is_action_just_pressed("switch_character"):
		_switch_to_next()


func _switch_to_next() -> void:
	for companion in companions:
		if is_instance_valid(companion):
			_deactivate()
			companion._activate(global_position)
			return


func _activate(spawn_position: Vector2) -> void:
	global_position = spawn_position
	is_active = true
	modulate.a = 1.0
	if has_node("Camera2D"):
		get_node("Camera2D").make_current()


func _deactivate() -> void:
	is_active = false
	_is_fighting = false
	modulate.a = 0.5
	velocity = Vector2.ZERO


func reset_to_start() -> void:
	global_position = starting_position
	velocity = Vector2.ZERO
