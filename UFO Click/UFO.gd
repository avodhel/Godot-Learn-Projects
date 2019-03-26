extends Area2D

var speed = 100
var direction = Vector2()
var width
var height
var hit = false # Ufo whether hit or not
var lose = false # Game over or not
var clicks = 0 # click count (score)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2
	direction.x = rand_range(-1, 1)
	direction.y = rand_range(-1, 1)
	direction = direction.normalized()
	width = get_viewport_rect().size.x # width of the game window
	height = get_viewport_rect().size.y # height of the game window

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	if position.x < 0:
		direction.x = -direction.x
	if position.x > width:
		direction.x = -direction.x
	if position.y < 0:
		direction.y = -direction.y
	if position.y > height:
		direction.y = -direction.y

func _on_UFO_input_event(viewport, event, shape_idx): # function runs if clicked to the ufo
	if lose: # if game over 
		return  # leave this function
	if event  is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed: #if left button clicked
		direction.x = rand_range(-1, 1)
		direction.y = rand_range(-1, 1)
		direction = direction.normalized()
		position.x = rand_range(1, width -1)
		position.y = rand_range(1, height -1)
		speed += 5
		hit = true
		$HitSound.play()
