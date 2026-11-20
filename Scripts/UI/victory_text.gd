extends TextureRect

@onready var label: Label = $Label

const base_text = "Congratulations ! You finished level"

func on_win() -> void :
	label.text = base_text + " " + str(SceneLoader.get_current_level_index() + 1)
	visible = true
	grab_focus()
