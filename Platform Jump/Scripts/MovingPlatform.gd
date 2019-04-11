extends Path2D

export var speed = 250

var direction = 1 #left or right
var sprite_half_width

onready var path_follow = $PathFollow
onready var platform = $PathFollow/Platform

func _ready():
	randomize()
	direction = 1 if rand_range(0,100) > 50 else -1
	sprite_half_width = platform.sprite_half_width
	
func _process(delta):
	path_follow.offset += speed * direction * delta
	if direction > 0 and path_follow.unit_offset > 0.99: #if moving right
		direction = -1
	elif direction < 0 and path_follow.unit_offset < 0.01: #if moving left 
		direction = 1

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
