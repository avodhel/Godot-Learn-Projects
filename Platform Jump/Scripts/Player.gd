extends KinematicBody2D

signal just_jumped

export (int) var speed = 500

onready var animated_sprite = $AnimatedSprite
onready var jump_audio = $JumpAudio

const GRAVITY = 1500
const GRAVITY_INCREMENT = 2500
const JUMP_DECREMENT = 100
const JUMP_FORCE = 40

var screen_width
var half_sprite_width
var jumping = false
var current_jump_force = 0
var current_gravity = 0
var highest_reached_position = 300
var death_position_offset = 1200
var score = 0

func _ready():
	score = abs(highest_reached_position) - 300
	screen_width = get_viewport_rect().size.x
	half_sprite_width = animated_sprite.frames.get_frame("idle", 0).get_width() / 2
	current_gravity = GRAVITY
	
func _process(delta):
	if !jumping: # if player doesn't jump
		_increment_gravity(delta)
		position.y += current_gravity * delta #player falls down to the screen
	else:
		position.y -= current_jump_force
		_decrement_jump(delta)
	
	highest_reached_position = position.y if position.y < highest_reached_position else highest_reached_position
	score = int(abs(highest_reached_position) - 300)
	
	if position.y >= highest_reached_position + death_position_offset:
		die()
	
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("ui_accept"):
		jump()
	
	_check_boundaries() #if player goes out of screen, teleport player the other side

func jump():
	if jumping:
		return
	current_gravity = 0
	jumping = true
	current_jump_force = JUMP_FORCE
	animated_sprite.play("jump")
	jump_audio.play()
	emit_signal("just_jumped")

func add_impulse(impulse): #when player steps on spring
	emit_signal("just_jumped")
	current_gravity = 0
	jumping = true
	current_jump_force = impulse
	animated_sprite.play("jump")

func die():
#	yield(get_tree().create_timer(2), "timeout")
	$"/root/PlayerData".save_highscore(score) #save highscore
	$"/root/LevelManager".change_scene("Menu") #back to the menu

func _increment_gravity(delta):
	current_gravity += GRAVITY_INCREMENT * delta
	if current_gravity >= GRAVITY:
		current_gravity = GRAVITY
		
func _decrement_jump(delta):
	current_jump_force -= JUMP_DECREMENT * delta
	if current_jump_force <= 0:
		current_jump_force = 0
		jumping = false
		animated_sprite.play("idle")

func _check_boundaries():#if player goes out of screen, teleport player the other side
	if position.x > screen_width:
		position.x = 0
	elif position.x < 0:
		position.x = screen_width



