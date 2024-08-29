extends Control

func _ready():
	pass


func _process(delta):
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn") #Goes back to the menu from ingame
	print("Escape Options pressed")
