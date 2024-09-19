extends Control
@onready var world = $"../../"

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
