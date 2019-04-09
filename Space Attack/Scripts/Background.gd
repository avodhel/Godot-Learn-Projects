extends Node2D

export var move_speed = 500

const offset = 64

onready var top = $TopBackground
onready var bottom = $BottomBackground

var top_position
var bottom_position

func _ready():
	top_position = top.position.y
	bottom_position = get_viewport_rect().size.y
#	print(get_viewport_rect().size.y) #450
	
func _process(delta):
	top.position.y += move_speed * delta
	bottom.position.y += move_speed * delta
	if top.position.y >= bottom_position + offset:
		top.position.y = top_position
	elif bottom.position.y >= bottom_position + offset:
		bottom.position.y = top_position
