extends Area2D

onready var shoot_timer = $ShootTimer
onready var collision = $CollisionShape2D

export var speed = 50
export var health = 30
export (PackedScene) var projectile

var dead = false 
var can_shoot = true

func _ready():
	pass
	
func _process(delta):
	if can_shoot:
		_shoot()
		
func _shoot():
	var new_projectile = projectile.instance()
	new_projectile.position = global_position
	get_tree().get_root().add_child(new_projectile)
	can_shoot = false
	shoot_timer.start()
	
func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		collision.queue_free()
		hide()

func _on_ShootTimer_timeout():
	can_shoot = true
