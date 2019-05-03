extends Area2D

export (Array, PackedScene) var demo_objects

onready var demo1_scene = "res://demo/demo.tscn"

var velocity = Vector2()

func _ready():
	_chose_object()

func _process(delta):
	_control(delta)

func _chose_object():
	randomize()
	var rand_obj = randi() % demo_objects.size()
	var demo_object = demo_objects[rand_obj].instance()
#	var demo_object_sprite = demo_object.get_node_and_resource("Sprite")
#	self.get_node("Sprite").modulate = demo_object.get_node("Sprite").modulate
#	if self.name == "MyDemoObject":
#		self.get_tree().change_scene(demo1_scene)

func _control(delta):
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, 0)
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, 0)
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(0, 0)
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(0, 0)
		velocity.x += 1
	_move(delta)

func _move(delta):
	position += (velocity * delta ).normalized() * 3