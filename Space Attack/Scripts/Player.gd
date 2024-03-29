extends KinematicBody2D

export var speed = 500
export var health = 100
export (PackedScene) var projectile

onready var sprite = $Sprite
onready var shoot_timer = $ShootTimer
onready var restart_timer = $RestartTimer
onready var laser_sound = $LaserSound
onready var health_bar = $HealthBar

var screensize
var half_sprite_size
var can_shoot = true
var dead = false

func _ready():
	screensize = get_viewport_rect().size
	half_sprite_size = (sprite.texture.get_width() * scale.x) / 2
	health_bar.max_value = health
	health_bar.value = health

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
		laser_sound.play()
		
	position.x = clamp(position.x, half_sprite_size, screensize.x - half_sprite_size)

func _on_ShootTimer_timeout():
	can_shoot = true
	
func add_damage(damage):
	if dead:
		return
	health -= damage
	health_bar.value = health
	if health <= 0:
		dead = true
		health = 0
		health_bar.value = health
		restart_timer.start()
		set_process(false)
		sprite.queue_free()
		health_bar.queue_free()

func _on_RestartTimer_timeout():
	get_tree().reload_current_scene()
