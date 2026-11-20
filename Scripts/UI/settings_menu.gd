extends Menu

@onready var music_slider: HSlider = $HBoxContainer/VBoxContainer2/MusicSlider
@onready var sfx_slider: HSlider = $HBoxContainer/VBoxContainer2/SFXSlider

func _ready():
	if Engine.has_singleton("SoundPlayer"):
		music_slider.value = SoundPlayer.get_music_volume()
		sfx_slider.value = SoundPlayer.get_sfx_volume()
		music_slider.value_changed.connect(func(value) : SoundPlayer.set_music_volume(value))
		sfx_slider.value_changed.connect(func(value) : SoundPlayer.set_sfx_volume(value))
