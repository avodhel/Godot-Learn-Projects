extends Node

onready var message = $Message
onready var greater_button = $GreaterButton
onready var lesser_button = $LesserButton
onready var right_button = $RightButton
onready var ichose_button = $IChoseButton

var guess
var min_guessed = 0
var max_guessed = 1000
var ended = false

func _ready():
	guess = (min_guessed + max_guessed) / 2
	message.text = "Is " + str(guess) + " your number ?"
	
func _process(delta):
	if Input.is_action_just_pressed("up"): # works if just pressed "up". (not every frame)
		_try_guess("up")
	elif Input.is_action_just_pressed("down"):
		_try_guess("down")
	elif Input.is_action_just_pressed("space"):
		if ended:
			_restart_game()
		else:
			_end_game()

#type should be "up" = greater or "down" = lesser
func _try_guess(type):
	if type == "up":
		min_guessed = guess
	else:
		max_guessed = guess
	guess = (min_guessed + max_guessed) / 2
	message.text = "Is " + str(guess) + " your number ?"
	
	if max_guessed - min_guessed == 2:
		ended = true
		message.text = "Yes! I knew it! Your number is " + str((min_guessed + max_guessed) / 2) + "!"
		$RightButton.text = "Restart"
	
func _end_game():
	ended = true
	message.text = "Yes! I knew it! Your number is " + str(guess) + "!"
	$RightButton.text = "Restart"
	
func _restart_game():
	get_tree().reload_current_scene()

func _on_GreaterButton_pressed():
	_try_guess("up")

func _on_LesserButton_pressed():
	_try_guess("down")

func _on_RightButton_pressed():
	if ended:
		_restart_game()
	else:
		_end_game()

func _on_IChoseButton_pressed():
	ichose_button.hide()
	message.show()
	greater_button.show()
	lesser_button.show()
	right_button.show()
