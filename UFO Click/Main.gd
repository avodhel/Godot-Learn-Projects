extends Node2D

var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$LoseLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $UFO.hit == false and hit == true: # if ufo didn't click but game over are clicked
		#print("lose")
		$UFO.lose = true
		$LoseLabel.show()
	if $UFO.hit == true:
		$UFO.clicks += 1
		$ClicksLabel.text = "Clicks: " + str($UFO.clicks)
	$UFO.hit = false
	hit = false

func _on_GameOverArea_input_event(viewport, event, shape_idx):
	if event  is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed: #if left button clicked 
		hit = true
