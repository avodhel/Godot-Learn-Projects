extends Node

export(PackedScene) var trunk_scene

onready var first_trunk_position = $FirstTrunkPosition

var last_spawn_position

func _ready():
	last_spawn_position = first_trunk_position.position
	_spawn_first_trunks()
	
func _spawn_first_trunks():
	for counter in range(5):
		var new_trunk = trunk_scene.instance()
		add_child(new_trunk)
		new_trunk.position = last_spawn_position
		last_spawn_position.y -= new_trunk.sprite_height
		new_trunk.initialize_trunk(false, false)
