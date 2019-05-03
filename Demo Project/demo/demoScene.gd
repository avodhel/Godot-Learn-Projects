extends Node2D

export (Array, PackedScene) var demo_objects

onready var my_demo_object = $MyDemoObject
onready var demo_spawn_loc = $MyDemoObject/Path2D/PathFollow2D
onready var object_timer = $ObjectTimer
onready var demoChart = $demoHud/demoChart
onready var demo_hud = $demoHud
onready var deneme = $deneme


func _ready():
	my_demo_object.hide()
	demoChart.hide()

func _on_ChooseScreen_start_game(whichobject):
	if whichobject == "obj1":
		_load_scene("res://demo/demo.tscn", "my_demo1")
	elif whichobject == "obj2":
		_load_scene("res://demo/demo2.tscn", "my_demo2")
	elif whichobject == "obj3":
		_load_scene("res://demo/demo3.tscn", "my_demo3")

	my_demo_object.show()
	object_timer.start()
	demoChart.show()

func _load_scene(path, set_name):
		var obj_scene = load(path)
		var obj_instance = obj_scene.instance()
		obj_instance.set_name(set_name)
		add_child(obj_instance)
		obj_instance.set_script(preload("res://demo/MyDemoObject.gd"))
		obj_instance.position = my_demo_object.position

func _on_ObjectTimer_timeout():
	demo_spawn_loc.set_offset(randi())
	var demo_object = demo_objects[randi() % demo_objects.size()].instance()
	add_child(demo_object)
	demo_object.position = demo_spawn_loc.global_position
	if demo_object.is_in_group("blue"):
		demoChart.increase_or_reduce("demo1", "inc")
	elif demo_object.is_in_group("green"):
		demoChart.increase_or_reduce("demo2", "inc")
	elif demo_object.is_in_group("purple"):
		demoChart.increase_or_reduce("demo3", "inc")
		
	demo_object.connect("object_died", self, "_on_object_died")
	
func _on_object_died(whichobject):
	if whichobject == "demo1":
		demoChart.increase_or_reduce(whichobject, "red")
	elif whichobject == "demo2":
		demoChart.increase_or_reduce(whichobject, "red")
	elif whichobject == "demo3":
		demoChart.increase_or_reduce(whichobject, "red")
