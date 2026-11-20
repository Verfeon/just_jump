extends Area2D

signal win_signal


func _on_trophy_grabbed(body) -> void:
	if body.name == "Player":
		win_signal.emit()
