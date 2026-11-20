extends Label


const controls = {
	Controls.CONTROL_MODE.KEYBOARD_MOUSE: "Hold \"SPACE\" to charge and release it to jump towards the mouse cursor",
	Controls.CONTROL_MODE.CONTROLLER : "Hold bottom button to charge and release it to jump in the left joystick direction"
}

func _ready():
	if Engine.has_singleton("Controls"):
		text = controls[Controls.getControlMode()]
		Controls.controls_changed_signal.connect(func(control_mode) : text = controls[control_mode])
