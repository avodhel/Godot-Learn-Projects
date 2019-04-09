extends KinematicBody2D

export var speed = 500

onready var sprite = $Sprite

var screensize
var half_sprite_size

func _ready():
	screensize = get_viewport_rect().size
	half_sprite_size = (sprite.texture.get_width() * scale.x) / 2

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
		
	position.x = clamp(position.x, half_sprite_size, screensize.x - half_sprite_size)