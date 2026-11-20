extends AnimatedSprite2D

var currentAnimation = "Idle"

func idle() -> void:
	play("Idle")
	
func falling() -> void:
	play("Falling")

func prepareJump() -> void:
	play("PrepareJump")

func jump(direction) -> void:
	if direction.y < -0.5:
		if direction.x < -0.5:
			play("JumpUpLeft")
		elif direction.x > 0.5:
			play("JumpUpRight")
		else:
			play("JumpUp")
	elif direction.x < -0.5:
		play("JumpLeft")
	else:
		play("JumpRight")

func dies_from_falling() -> void:
	play("DiesFromFalling")
	animation_finished.connect(func() : get_tree().reload_current_scene())
