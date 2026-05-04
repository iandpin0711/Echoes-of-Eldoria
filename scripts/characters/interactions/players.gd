extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export var inv: Inv
@export var textbox: CanvasLayer

var char_index = 0
var is_busy = false
var in_zone = false
var last_dir = Vector2.RIGHT

const SPEED = 200.0
const JUMP_FORCE = -400.0
const GRAVITY = 800.0
const CHARACTERS = [
	"res://animations/warrior.tres",
	"res://animations/lancer.tres",
	"res://animations/archer.tres",
]
const ARROW = preload("res://scenes/archer.tscn")

func _ready():
	load_character()
	add_to_group("Player")

func _physics_process(delta):
	if is_busy:
		return
	
	var scene_name = get_tree().current_scene.name
	
	if scene_name == "InteriorCastle":
		_process_castle(delta)
	else:
		_process_overworld()

func _process_overworld():
	if Input.is_action_just_pressed("attack"):
		is_busy = true
		if sprite.flip_h:
			last_dir.x = -abs(last_dir.x)
		else:
			last_dir.x = abs(last_dir.x)
		sprite.play("attack")
		if char_index == 2:
			anim_player.play("shoot")
		await sprite.animation_finished
		is_busy = false
	elif Input.is_action_just_pressed("interact"):
		char_index = (char_index + 1) % CHARACTERS.size()
		load_character()
	else:
		var dir = Vector2.ZERO
		if Input.is_action_pressed("right"):
			dir.x = 1
		elif Input.is_action_pressed("left"):
			dir.x = -1
		if Input.is_action_pressed("down"):
			dir.y = 1
		elif Input.is_action_pressed("up"):
			dir.y = -1
		if dir != Vector2.ZERO:
			last_dir = dir
			velocity = dir.normalized() * SPEED
			move_and_slide()
			if dir.x != 0:
				sprite.flip_h = dir.x < 0
			sprite.play("run")
		else:
			velocity = Vector2.ZERO
			sprite.play("idle")

func _process_castle(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Salto
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_FORCE

	if Input.is_action_just_pressed("attack"):
		is_busy = true
		if sprite.flip_h:
			last_dir.x = -abs(last_dir.x)
		else:
			last_dir.x = abs(last_dir.x)
		sprite.play("attack")
		if char_index == 2:
			anim_player.play("shoot")
		await sprite.animation_finished
		is_busy = false
	elif Input.is_action_just_pressed("interact"):
		char_index = (char_index + 1) % CHARACTERS.size()
		load_character()
	else:
		var dir_x = 0
		if Input.is_action_pressed("right"):
			dir_x = 1
		elif Input.is_action_pressed("left"):
			dir_x = -1

		if dir_x != 0:
			last_dir.x = dir_x
			velocity.x = dir_x * SPEED
			sprite.flip_h = dir_x < 0
			sprite.play("run")
		else:
			velocity.x = 0
			sprite.play("idle")

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("enter") and in_zone:
		if textbox:
			textbox.hide_textbox()
		get_tree().change_scene_to_file("res://scenes/Map/InteriorCastle.tscn")

func load_character():
	sprite.sprite_frames = load(CHARACTERS[char_index])
	sprite.play("idle")

func _shoot_arrow():
	var arrow = ARROW.instantiate()
	var offset = Vector2(20, -20)
	if sprite.flip_h:
		offset.x = -20
	arrow.position = global_position + offset
	var dir = Vector2.RIGHT
	if sprite.flip_h:
		dir = Vector2.LEFT
	dir.y -= 0.3
	arrow.direction = dir
	get_parent().add_child(arrow)

func collect(item):
	inv.insert(item)
