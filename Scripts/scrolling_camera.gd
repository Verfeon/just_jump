extends Camera2D

const MIN_ZOOM = 0.5
const MAX_ZOOM = 1.
const ZOOM_SPEED = 0.1

var current_zoom = zoom.x

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("zoom_in"):
		apply_zoom(ZOOM_SPEED * delta)
		
	if Input.is_action_pressed("zoom_out"):
		apply_zoom(-ZOOM_SPEED * delta)


func apply_zoom(value: float) -> void:
	current_zoom = clampf(current_zoom + value, MIN_ZOOM, MAX_ZOOM)
	zoom = Vector2(current_zoom, current_zoom)

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventJoypadButton) and event.pressed:
		if event.is_action("zoom_in"):
			apply_zoom(ZOOM_SPEED)
			
		if event.is_action("zoom_out"):
			apply_zoom(-ZOOM_SPEED)
