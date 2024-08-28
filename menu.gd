extends Control

func _ready():
	pass


func _process(delta):
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	print("Start pressed")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://options.tscn")
	print("Options pressed")



func _on_quit_pressed() -> void:
	get_tree().quit()
	print("Quit pressed")
