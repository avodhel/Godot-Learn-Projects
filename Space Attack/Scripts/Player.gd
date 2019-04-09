extends KinematicBody2D

export var speed = 500
export (PackedScene) var projectile

onready var sprite = $Sprite
onready var shoot_timer = $ShootTimer

var screensize
var half_sprite_size
var can_shoot = true

func _ready():
	screensize = get_viewport_rect().size
	half_sprite_size = (sprite.texture.get_width() * scale.x) / 2

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
		
	if Input.is_action_pressed("shoot") and can_shoot:
		can_shoot = false
		var new_projectile = projectile.instance()
		get_parent().add_child(new_projectile) #adding projectiles to main scene as child
		new_projectile.position = position #setting player's position to projectile
		shoot_timer.start()
		
	position.x = clamp(position.x, half_sprite_size, screensize.x - half_sprite_size)

func _on_ShootTimer_timeout():
	can_shoot = true
