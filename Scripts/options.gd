extends Control

func _ready():
	pass


func _process(delta):
	pass
	

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	print("Escape Options pressed")
