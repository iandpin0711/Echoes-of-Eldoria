extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var inv: Inv

var char_index = 0
var is_busy = false

const SPEED = 200.0
const CHARACTERS = [
	"res://animations/warrior.tres",
	"res://animations/lancer.tres",
	"res://animations/archer.tres",
]

func _ready():
	load_character()

func _physics_process(_delta):
	if is_busy:
		return

	if Input.is_action_just_pressed("attack"):
		is_busy = true
		sprite.play("attack")
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
			velocity = dir.normalized() * SPEED
			move_and_slide()
			if dir.x != 0:
				sprite.flip_h = dir.x < 0
			sprite.play("run")
			
		else:
			velocity = Vector2.ZERO
			sprite.play("idle")

func load_character():
	sprite.sprite_frames = load(CHARACTERS[char_index])
	sprite.play("idle")
