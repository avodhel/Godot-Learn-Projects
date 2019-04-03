extends Node2D

export var speed = 1500
var direction = 1

onready var sprite = $Sprite
onready var left_axe = $LeftAxe
onready var right_axe = $RightAxe
onready var timer = $Timer

var sprite_height

func _ready():
	sprite_height = sprite.texture.get_height() * scale.y
	set_process(false) # process stopped  at start
	
func _process(delta):
	position.x += speed * direction * delta
	
func initialize_trunk(axe, right):
	if axe: # if we have axe on trunk
		if right: #if axe is on the right side
			left_axe.queue_free()
		else:
			right_axe.queue_free()
	else:
		left_axe.queue_free()
		right_axe.queue_free()

func remove_trunk(from_right): #detect where punch comes and removes trunk to opposite direction
	if from_right:
		direction = -1
	else:
		direction = 1
	timer.start()
	set_process(true) # start process again

func _on_Timer_timeout():
	queue_free()
