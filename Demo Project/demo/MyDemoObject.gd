extends Area2D

export (Array, PackedScene) var demo_objects

onready var demo1_scene = "res://demo/demo.tscn"

var velocity = Vector2()
var speed = 100

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
	if Input.is_action_pressed("ui_up"):
		velocity.y  -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y  += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x  -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x  += 1
	
	velocity  = velocity.normalized()  * speed * delta
	self.position += velocity

func _on_MyDemoObject_area_entered(area):
	print("detected: " + area.name)
