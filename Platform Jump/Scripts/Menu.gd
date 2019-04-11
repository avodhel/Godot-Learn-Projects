extends Node

func _on_PlayButton_pressed():
	$"/root/LevelManager".change_scene("Game")
