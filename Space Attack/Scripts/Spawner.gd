extends Node2D

export (PackedScene) var formation

onready var wave_label = $WaveLabel

var center 
var offset = 100
var wave_count = 0

func _ready():
	center = get_viewport().get_visible_rect().size.x / 2
	yield(get_tree().create_timer(2), "timeout") # wait 2 seconds to spawn first enemy group
	_spawn_formation()
	wave_label.text = "Wave: " + str(wave_count)
	
func _spawn_formation():
	wave_count += 1
	wave_label.text = "Wave: " + str(wave_count)
	randomize() # more random
	var position_x = rand_range(center - offset, center + offset)
	var position_y = -150
	var new_formation = formation.instance()
	new_formation.position = Vector2(position_x, position_y)
	add_child(new_formation)
	new_formation.connect("formation_defeated", self, "_on_formation_defeated")
	
func _on_formation_defeated(): #when formation_defeted signal emit, this func starts to work
	yield(get_tree().create_timer(5), "timeout") # wait 5 seconds to spawn new enemy group
	_spawn_formation() #spawn new formation
