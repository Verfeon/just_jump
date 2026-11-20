extends Control

@onready var settings_menu: Control = $settings_menu
@onready var credits_menu: Control = $credits_menu
@onready var controls_menu: Control = $controls_menu
@onready var levels_menu: Control = $Levels_menu


func _on_play_pressed():
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	levels_menu.visible = true
	
func _on_quit_pressed():
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	get_tree().quit()

func _on_credits_pressed():
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	credits_menu.visible = true

func _on_settings_pressed():
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	settings_menu.visible = true


func _on_controls_pressed():
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	controls_menu.visible = true
