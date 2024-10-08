extends CharacterBody2D

#All variables in the code.
@onready var health_bar = $healthbar
@onready var game_music = $gamemusic
@onready var sword_sound = $swordsound
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true
var current_dir = "none"
const speed = 110
var attack_ip = false




func _ready():
	health_bar.value = health

func _process(delta):
	health_bar.value = health




#Physical player functions
func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()


#This sends player back to menu if player health is equal to 0 or less than 0
	if health <= 0:
		player_alive = false #back to menu if player dies
		health = 0
		health_bar.value = health
		print ("player died")
		self.queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")


#This chunk of code is dependant on what key you're pressing "W,A,S,D" is the main movement of this
func player_movement(delta):
	
	if Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0

	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0 

	elif Input.is_action_pressed("down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0

	elif Input.is_action_pressed("up"):
		play_anim(1)
		current_dir = "up"
		velocity.y = -speed
		velocity.x = 0

	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
	
#This function allows the animation to run still dependant on which key you press "W,A,S,D"
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
	
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")
func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false 

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player health = " , health)




#This is where the attack animation is 
func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
			sword_sound.play()
			
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
			sword_sound.play()
			
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
			sword_sound.play()
			
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
			sword_sound.play() #In this line of code you should add a timer -
#cooldown as I am able to -
#click multiple times and the sound replays without finishing the audio file.


func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
