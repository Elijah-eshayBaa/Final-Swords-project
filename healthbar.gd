extends ProgressBar


func _ready() -> void:

	change_health(10)

func change_health(damage: int):
	var tween = create_tween()
	tween.tween_property(self, "value", value - damage, .2)
