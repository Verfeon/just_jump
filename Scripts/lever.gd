extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_actionned = false
signal lever_signal

func _on_lever_actionned(body):
	if body.name == "Player" and not is_actionned:
		animated_sprite.play("Closing")
		is_actionned = true
		lever_signal.emit()
