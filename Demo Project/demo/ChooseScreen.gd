extends CanvasLayer

signal start_game(whichobject)

onready var title = $Title
onready var show_object = $ShowObject
onready var hbox = $HBoxContainer
onready var vbox = $VBoxContainer
onready var demo_obj1 = preload("res://square.png")
onready var demo_obj2 = preload("res://round.png")
onready var demo_obj3 = preload("res://triangle.png")

var which_object

func _on_Button1_pressed():
	show_object.texture = demo_obj1
	which_object = "obj1"
	
func _on_Button2_pressed():
	show_object.texture = demo_obj2
	which_object = "obj2"


func _on_Button3_pressed():
	show_object.texture = demo_obj3
	which_object = "obj3"


func _on_start_pressed():
	emit_signal("start_game", which_object)
	title.hide()
	show_object.hide()
	hbox.hide()
	vbox.hide()