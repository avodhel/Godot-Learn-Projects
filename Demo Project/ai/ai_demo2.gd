extends Area2D

var speed = 200
var velocity = Vector2()

func _physics_process(delta):
	move(delta)

func move(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y  -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y  += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x  -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x  += 1
	
	velocity  = velocity.normalized()  * speed * delta
	self.position += velocity
	
#func _on_ai_demo2_body_entered(body):
#	print("bodycoll1 ile temas sağlandı")
#
#func _on_Visibility_body_entered(body):
#	print("visibility1 alanına girildi")


func _on_ai_demo2_area_entered(area):
	if !area.is_in_group("ai_demo_fov"):
#		print("bodycoll2 ile temas sağlandı")
#		print(area.name)
#		print(area.scale)
		pass


func _on_Visibility_area_entered(area):
	if !area.is_in_group("ai_demo"):
#		print("visibility2 alanına girildi")
#		print(area.name)
#		print(area.scale)
		pass