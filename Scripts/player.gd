extends CharacterBody2D

class_name Player

@onready var jump_power_bar = $JumpPowerBar
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var falling_particles: GPUParticles2D = $FallingParticles
@onready var jump_particles: GPUParticles2D = $JumpParticles

signal jump_signal(direction : Vector2)
signal prepare_jump_signal
signal idle_signal
signal falling_signal
signal death_signal

const JUMP_FORCE = 1000.0
const MAX_JUMP_POWER = 100.0
const WALL_JUMP_POWER = 80
const CHARGING_SPEED = 200
const INERTIA_FACTOR = 0.8
const FRICTION_FACTOR = 0.50
const TOTAL_JUMPING_TIME = 0.5
const TIME_FOR_WALL_JUMP = 0.1

var power = 0.0
var charging = false
var is_space_pressed = false
var was_space_pressed = false
var was_on_floor = false
var jumping = false
var jumping_time = 0.
var can_wall_jump = false
var time_since_last_wall = 0.
var state = State.IDLE
var jump_direction

enum State {
	IDLE, 
	CHARGING,
	JUMPING,
	FALLING
}

func _ready():
	if Engine.has_singleton("SoundPlayer"):
		jump_signal.connect(func(_direction): SoundPlayer.play_jump_sfx())
		idle_signal.connect(func(): SoundPlayer.play_land_sfx())

func _physics_process(delta: float) -> void:
	velocity = get_real_velocity()
	velocity += get_gravity() * delta

	var grounded = is_on_floor()

	is_space_pressed = Input.is_action_pressed("jump")

	if grounded:
		velocity *= (1-(1-FRICTION_FACTOR)*delta)
		if (velocity.x <= 1) and state != State.CHARGING:
			state = State.IDLE
			idle_signal.emit()
		if not was_on_floor:
			state = State.IDLE
			idle_signal.emit()
			falling_particles.emitting = false

	if is_on_wall():
		can_wall_jump = true
		animated_sprite.modulate = Color(2.454, 2.454, 2.454, 0.784)
	
	if can_wall_jump:
		time_since_last_wall += delta
		if time_since_last_wall >= TIME_FOR_WALL_JUMP:
			time_since_last_wall = 0
			can_wall_jump = false
			animated_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	# wall jump
	if is_space_pressed and not was_space_pressed and not grounded and can_wall_jump:
		jump(WALL_JUMP_POWER, false)

	# regular jump
	if is_space_pressed and grounded:
		state = State.CHARGING
		power = clamp(power + CHARGING_SPEED * delta, 0, MAX_JUMP_POWER)
		prepare_jump_signal.emit()
	elif state == State.CHARGING:
		jump(power)
		power = 0

	if not grounded and velocity.y > 3 and state != State.FALLING:
		state = State.FALLING
		falling_signal.emit()
		falling_particles.emitting = true

	if state == State.JUMPING:
		jumping_time += delta
		if jumping_time >= TOTAL_JUMPING_TIME:
			state = State.IDLE
			idle_signal.emit()
			jumping_time = 0.
	
	
	jump_power_bar.value = power
	jump_power_bar.update_bar_color(power/MAX_JUMP_POWER)

	was_space_pressed = is_space_pressed
	was_on_floor = grounded
	move_and_slide()

func jump(strength : float, apply_inertia : bool = true):
	state = State.JUMPING
	var direction
	match (Controls.getControlMode()):
		Controls.CONTROL_MODE.KEYBOARD_MOUSE:
			var mouse_pos = get_global_mouse_position()
			direction = (mouse_pos - global_position).normalized()
			
		Controls.CONTROL_MODE.CONTROLLER:
			var x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
			var y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
			direction = Vector2(x, y).normalized()
	
	var inertia = velocity * INERTIA_FACTOR if apply_inertia else Vector2(0., 0.)
	velocity = (inertia +  direction * JUMP_FORCE * strength/MAX_JUMP_POWER)
	jump_particles.restart()
	jump_direction = direction
	jump_signal.emit(direction)


func dies_from_falling() -> void:
	death_signal.emit()
