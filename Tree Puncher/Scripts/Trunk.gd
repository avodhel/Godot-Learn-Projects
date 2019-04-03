extends Node2D

onready var sprite = $Sprite

var sprite_height

func _ready():
	sprite_height = sprite.texture.get_height() * scale.y