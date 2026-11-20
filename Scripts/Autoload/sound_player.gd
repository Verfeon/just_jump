extends Node2D

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer


func _ready():
	if Engine.has_singleton("SoundPlayer") and Engine.get_singleton("SoundPlayer") != self:
		queue_free()
		return
	
	Engine.register_singleton("SoundPlayer", self)

func set_music_volume(volume):
	volume = clamp(volume, 0, 1)
	music_player.volume_linear = volume
	
func set_sfx_volume(volume):
	volume = clamp(volume, 0, 1)
	sfx_player.volume_linear = volume
	
func get_music_volume() -> float:
	return music_player.volume_linear
	
func get_sfx_volume() -> float:
	return sfx_player.volume_linear

func play_jump_sfx():
	sfx_player.stream = load("res://art/Audio/SFX/SlimeJump.mp3")
	sfx_player.play()

func play_land_sfx():
	sfx_player.stream = load("res://art/Audio/SFX/SlimeLanding.mp3")
	sfx_player.play()

func play_win_sfx():
	sfx_player.stream = load("res://art/Audio/SFX/Win.mp3")
	sfx_player.play()

func play_button_sfx():
	sfx_player.stream = load("res://art/Audio/SFX/Button.mp3")
	sfx_player.play()
