extends CharacterBody2D


const speed = 1000
func _physics_process(delta):
	player_movement(delta)


func player_movement(delta):
	
	if Input.is_action_pressed("right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("down"):
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("up"):
		velocity.y = -speed
		velocity.x = 0
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

