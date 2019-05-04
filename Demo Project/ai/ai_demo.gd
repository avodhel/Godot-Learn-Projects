extends Area2D

const MAX_SPEED = 50
const MAX_FORCE = 1
var velocity = Vector2()
onready var target = self.position

export (int, "SEEK", "FLEE") var mode = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	_move(delta)

func _move(delta):
	velocity = steer(target)
	move_local_x(velocity.x * delta)
	move_local_y(velocity.y * delta)
	target = get_global_mouse_position()

func steer(target):
	var desired_velocity = (target - self.position).normalized() * MAX_SPEED
	if mode == 0:
		pass
	elif mode == 1:
		desired_velocity = -desired_velocity
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)