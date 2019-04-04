extends Node

export(PackedScene) var trunk_scene

onready var first_trunk_position = $FirstTrunkPosition
onready var grave = $Grave
onready var time_left = $TimeLeft
onready var player = $Player
onready var timer = $Timer
onready var score_text = $ScoreText

var last_spawn_position
var last_has_axe = false
var last_axe_right = false
var dead = false
var score_counter = 0

var trunks = []

func _ready():
	score_text.text = str(score_counter)
	last_spawn_position = first_trunk_position.position
	_spawn_first_trunks()
	
func _process(delta):
	score_text.text = str(score_counter)
	
	if dead:
		return
	time_left.value -= delta
	if time_left.value <= 0:
		die()
	
func _spawn_first_trunks():
	for counter in range(5):
		var new_trunk = trunk_scene.instance()
		add_child(new_trunk)
		new_trunk.position = last_spawn_position
		last_spawn_position.y -= new_trunk.sprite_height
		new_trunk.initialize_trunk(false, false)
		trunks.append(new_trunk)
		
func _add_trunk(axe, axe_right):
	var new_trunk = trunk_scene.instance()
	add_child(new_trunk)
	new_trunk.position = last_spawn_position
	new_trunk.initialize_trunk(axe, axe_right)
	trunks.append(new_trunk)
		
func punch_tree(from_right):
	if !last_has_axe:
		if rand_range(0, 100) > 50:
			last_axe_right = rand_range(0, 100) > 50
			last_has_axe = true
			#spawn trunk
		else:
			last_has_axe = false
			#spawn trunk
	else:
		if rand_range(0, 100) > 50:
			last_has_axe = true
			#spawn trunk with an axe on same position as the last
		else:
			last_has_axe = false
			#spawn a trunk without an axe
	_add_trunk(last_has_axe, last_axe_right)

	trunks[0].remove_trunk(from_right)
	trunks.pop_front() #remove first array element, so first trunk
	for trunk in trunks:
		trunk.position.y += trunk.sprite_height
		
	time_left.value += 0.25 #after every punch increase time
	if time_left.value > time_left.max_value:
		time_left.value = time_left.max_value
	
	score_counter += 1
	
func die():
	grave.position.x = player.position.x
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true

func _on_Timer_timeout():
	get_tree().reload_current_scene() #restart game
