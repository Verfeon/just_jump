extends Menu

@onready var levels: GridContainer = $CenterContainer/Levels

func _ready() -> void:
	var scores = DataManager.load_scores()
	for i in range (SceneLoader.get_level_count()):
		var button = Button.new()
		button.text = "LEVEL%d" % (i+1)
		button.pressed.connect(func() : SceneLoader.go_to_level(i))
		if scores.get(i-1, -1) == -1 and i != 0:
			button.disabled = true
		levels.add_child(button)
