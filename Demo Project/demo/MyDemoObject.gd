extends Area2D

export (Array, PackedScene) var demo_objects

onready var demo1_scene = "res://demo/demo.tscn"

var velocity = Vector2()
var speed = 100
var moves = {'ui_up' : Vector2(0, -1),
             'ui_down': Vector2(0, 1),
             'ui_left': Vector2(-1, 0),
             'ui_right': Vector2(1, 0)}

func _ready():
	_chose_object()

func _process(delta):
	_control(delta)

func _chose_object():
	randomize()
	var rand_obj = randi() % demo_objects.size()
	var demo_object = demo_objects[rand_obj].instance()

func _control(delta):
	velocity = Vector2()
	
	for dir in moves.keys():
		if Input.is_action_pressed(dir):
			velocity = moves[dir]

	velocity  = velocity.normalized()  * speed * delta
	self.position += velocity

func _on_MyDemoObject_area_entered(area):
	print("detected: " + area.name)