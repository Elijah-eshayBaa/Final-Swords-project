extends Node2D
#This isn't being used in the game itself (was just testing) unable to delete...
@onready var pause_menu = $PauseMenu/Camera2D
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused
