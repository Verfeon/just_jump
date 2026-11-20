extends Label


func _ready() -> void:
	var highscore = DataManager.get_highscore()
	if highscore == -1:
		text = "No highscore"
	else:
		@warning_ignore("integer_division")
		var minutes = highscore / 60
		var seconds = highscore % 60
		text = "Highscore : %02d:%02d" % [minutes, seconds]
