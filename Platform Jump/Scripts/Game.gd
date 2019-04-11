extends Node

export (Array, PackedScene) var platforms
export (Array, PackedScene) var special_platforms

onready var player = $Player
onready var score_text = $UI/Score

const MIN_INTERVAL = 100 #min interval between two platforms
const MAX_INTERVAL = 250 #max interval between two platforms
const INITIAL_PLATFORMS_COUNT = 40 #max platform number on the screen
const SPECIAL_PLATFORM_CHANCE = 20

var current_min_interval
var current_max_interval
var last_spawn_height
var screen_size

func _ready():
	last_spawn_height = get_viewport().get_visible_rect().size.y
	screen_size = get_viewport().get_visible_rect().size.x
	current_min_interval = MIN_INTERVAL
	current_max_interval = MAX_INTERVAL
	_spawn_first_platforms()

func _process(delta):
	score_text.text = str(player.score)

func _spawn_first_platforms():
	for counter in range(INITIAL_PLATFORMS_COUNT):
		_spawn_platform()

func _spawn_platform():
	var index
	var new_platform
	
	if rand_range(0, 100) > 100 - SPECIAL_PLATFORM_CHANCE:
		index = rand_range(0, special_platforms.size())
		new_platform = special_platforms[index].instance()
	else:
		index = rand_range(0, platforms.size())
		new_platform = platforms[index].instance()
	
	add_child(new_platform)
	var spawn_x = rand_range(0+ new_platform.sprite_half_width, screen_size - new_platform.sprite_half_width)
	var spawn_position = Vector2(spawn_x, last_spawn_height)
	new_platform.position = spawn_position
	last_spawn_height -= rand_range(current_min_interval, current_max_interval)
	current_min_interval += 5
	current_max_interval += 7.5
	current_min_interval = clamp(current_min_interval, MIN_INTERVAL, MAX_INTERVAL / 0.75)
	current_max_interval = clamp(current_max_interval, MIN_INTERVAL, MAX_INTERVAL)
	
func _on_Player_just_jumped():#when player jumps
	for counter in range(3):
		_spawn_platform()
