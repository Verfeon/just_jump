extends Label

var start_time := 0.0
var counting = true

var time : int
var highscore

func _ready() -> void:
	start_time = Time.get_ticks_msec() / 1000.0
	highscore = DataManager.get_highscore()

func _process(_delta) -> void:
	if counting:
		time = int((Time.get_ticks_msec() / 1000.0) - start_time)
		if time < highscore or highscore == -1:
			add_theme_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))
		else :
			add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
			
		
		@warning_ignore("integer_division")
		var minutes = time / 60
		var seconds = time % 60
		var formatted_time = "%02d:%02d" % [minutes, seconds]
		
		text = formatted_time

func stop_counting() -> void:
	counting = false

func get_time() -> int:
	return time
