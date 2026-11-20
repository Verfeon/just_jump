extends Node

var high_score_filename = "user://HighScores.save"

func _ready() -> void:
	if not FileAccess.file_exists(high_score_filename):
		print("file empty")
		save_scores({})

func save_highscore(score: int) -> void:
	var scores = load_scores()
	var current_level_index = SceneLoader.current_level_index
	var highscore = scores.get(current_level_index, -1)
	if score < highscore or highscore == -1:
		scores[current_level_index] = score
		save_scores(scores)

func get_highscore() -> int:
	var scores = load_scores()
	var current_level_index = SceneLoader.current_level_index
	var highscore = scores.get(current_level_index, -1)
	return highscore

func save_scores(scores: Dictionary):
	var file = FileAccess.open(high_score_filename, FileAccess.WRITE)
	file.store_var(scores)
	file.close()

func load_scores() -> Dictionary:
	if FileAccess.file_exists(high_score_filename):
		var file = FileAccess.open(high_score_filename, FileAccess.READ)
		var scores = file.get_var()
		file.close()
		return scores
	return {}
