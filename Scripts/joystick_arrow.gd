extends Sprite2D

const BASE_ANGLE = PI/4  #because arrow is diagonal by default

var radius = 50

func _process(_delta: float):
	visible = false
	if (Engine.has_singleton("Controls")):
		if (Controls.getControlMode() == Controls.CONTROL_MODE.CONTROLLER):
			visible = true
			var x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
			var y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
			var direction = Vector2(x, y).normalized()
			if (direction.length() <= 0.01):
				visible = false
				return
			var angle = direction.angle()
			rotation = angle + BASE_ANGLE
			position = Vector2(cos(angle), sin(angle)) * radius
