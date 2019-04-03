extends Node

export (PackedScene) var Mob
var score

var distance

func _ready():
	randomize()
	
#	distance = $Player.position - $MobPath2.position
#	print(distance)

#func _process(delta):
#	if $Player.position.x < 0 and $Player.position.y < 0:
#		$MobPath2.position = $Player.position - Vector2(distance.x, distance.y)
#	if $Player.position.x > 0 and $Player.position.y > 0:
#		$MobPath2.position = $Player.position - Vector2(distance.x, distance.y)
#	if $Player.position.x < 0 and $Player.position.y > 0:
#		$MobPath2.position = $Player.position - Vector2(distance.x, distance.y)
#	if $Player.position.x > 0 and $Player.position.y < 0:
#		$MobPath2.position = $Player.position - Vector2(distance.x, distance.y)

func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()

func game_over():
	$DeathSound.play()
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func _on_MobTimer_timeout():
	# choose a random location on the Path2D
	$Player/MobPath2/MobSpawnLocation2.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $Player/MobPath2/MobSpawnLocation2.rotation + PI/2
	mob.position = $Player/MobPath2/MobSpawnLocation2.global_position
	# add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
