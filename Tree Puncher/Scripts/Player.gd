extends Node2D

onready var animation = $Animation

func _ready():
	pass
	
func _input(event):
	#if mouse clicked or screen touched
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		animation.play("punch")