extends Node

signal controls_changed_signal(CONTROL_MODE)

enum CONTROL_MODE {
	KEYBOARD_MOUSE,
	CONTROLLER
}

var current_control_mode = CONTROL_MODE.KEYBOARD_MOUSE

func _ready():
	if Engine.has_singleton("Controls") and Engine.get_singleton("Controls") != self:
		queue_free()
		return
	
	Engine.register_singleton("Controls", self)
	
func _input(event):
	if event is InputEventMouseMotion and current_control_mode != CONTROL_MODE.KEYBOARD_MOUSE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		current_control_mode = CONTROL_MODE.KEYBOARD_MOUSE
		controls_changed_signal.emit(current_control_mode)
	elif event is InputEventJoypadButton and event.pressed and current_control_mode != CONTROL_MODE.CONTROLLER:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		current_control_mode = CONTROL_MODE.CONTROLLER
		controls_changed_signal.emit(current_control_mode)

func getControlMode() -> CONTROL_MODE:
	return current_control_mode

func get_direction(player: CharacterBody2D) -> Vector2:
	var direction
	match (Controls.getControlMode()):
		Controls.CONTROL_MODE.KEYBOARD_MOUSE:
			var mouse_pos = player.get_global_mouse_position()
			if Engine.has_singleton("Player"):
				var player_position = Engine.get_singleton("Player").transform.origin
				direction = (mouse_pos - player_position).normalized()
			
		Controls.CONTROL_MODE.CONTROLLER:
			var x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
			var y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
			direction = Vector2(x, y).normalized()
	return direction
