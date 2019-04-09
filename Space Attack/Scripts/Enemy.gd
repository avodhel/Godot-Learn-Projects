extends Area2D

signal was_defeated

onready var shoot_timer = $ShootTimer
onready var collision = $CollisionShape2D
onready var audio = $Audio
onready var health_bar = $HealthBar

export var speed = 50
export var health = 30
export (PackedScene) var projectile
export (AudioStreamSample) var shoot_audio
export (AudioStreamSample) var explosion_audio

var dead = false 
var can_shoot = true

func _ready():
	audio.stream = shoot_audio
	health_bar.max_value = health
	health_bar.value = health
	
func _process(delta):
	if can_shoot:
		_shoot()
		
func _shoot():
	if dead: # if enemy is dead, can't shoot to our ship
		return

	var new_projectile = projectile.instance()
	new_projectile.position = global_position
	get_tree().get_root().add_child(new_projectile)
	can_shoot = false
	shoot_timer.start()
	audio.play()
	
func add_damage(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		dead = true
		health = 0
		health_bar.value = health
		collision.queue_free()
		hide()
		emit_signal("was_defeated")
		audio.stream = explosion_audio
		audio.play()

func _on_ShootTimer_timeout():
	can_shoot = true
