extends Control

@onready var settings_menu: Control = $UI/settings_menu
@onready var menu_button: Button = $UI/HBoxContainer/Menu
@onready var victory_text: TextureRect = $UI/VictoryText
@onready var time: Label = $UI/HBoxContainer/Time

func _input(event) -> void:
	if event is InputEventJoypadButton and event.pressed and event.button_index == JOY_BUTTON_Y:
		menu_button.grab_focus()
		

func _on_menu_button_pressed() -> void:
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_settings_button_pressed() -> void:
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	settings_menu.visible = true
	settings_menu.grab_focus()


func _on_retry_pressed() -> void:
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	get_tree().reload_current_scene()


func _on_next_level_pressed() -> void:
	if Engine.has_singleton("SoundPlayer"):
		SoundPlayer.play_button_sfx()
	SceneLoader.go_to_next_level()

func _on_win() -> void:
	victory_text.on_win()
	time.stop_counting()
	DataManager.save_highscore(time.get_time())
