extends CharacterBody2D
#These are the variables of the code 
@onready var slime_sound = $slimesound
var speed = 85
var player_chase = false
var player = null 
var health = 60
var can_take_damage = true
var player_inattack_zone = false

@onready var health_bar = $healthbar

func _ready():
	health_bar.value = health
	
func _process(delta):
	health_bar.value = health




func _physics_process(delta):
	
	deal_with_damage()
	if player_chase:
		position += (player.position - position)/speed


		$AnimatedSprite2D.play("walk")
		slime_sound.play()
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false 
	else:
		$AnimatedSprite2D.play("idle")
		slime_sound.play()



func _on_detection_area_body_entered(body):
	player = body
	player_chase = true 
	slime_sound.play()


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass





func _on_enemy_hitbox_body_entered(body): #This chunk tells us when the player has entered the enititys zone allowing entity to attack
	if body.has_method("player"):
		player_inattack_zone = true
		slime_sound.play()

func _on_enemy_hitbox_body_exited(body: Node2D) -> void: #When player outside of entitys zone it stops going after them
	if body.has_method("player"):
		player_inattack_zone = false

#This chunk shoes the amount of damage the slime can take whilt also putting its current health in the output
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <=0:
				health_bar.value = health
				print("player has eliminated a slime")
				self.queue_free()

#This is the cooldown on the slimes attack 
func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
