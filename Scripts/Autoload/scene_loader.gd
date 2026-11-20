extends Node

@export var levels_folder : String
@export var level_scenes : Array[PackedScene] = []

var current_level_index = 0

#func _ready() -> void:
	#load_level_scenes()

func load_level_scenes():
	var dir := DirAccess.open(levels_folder)
	if dir == null:
		push_error("Impossible d'ouvrir le dossier : %s" % levels_folder)
		level_scenes = []
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tscn"):
			level_scenes.append(levels_folder.path_join(file_name))
		file_name = dir.get_next()
	dir.list_dir_end()


func go_to_next_level() -> void:
	current_level_index += 1
	
	if current_level_index < level_scenes.size():
		get_tree().change_scene_to_packed(level_scenes[current_level_index])
	else:
		print("Plus de niveaux disponibles !")

func go_to_level(level_index: int) -> void:
	current_level_index = level_index
	get_tree().change_scene_to_packed(level_scenes[level_index])

func get_level_count() -> int:
	return level_scenes.size()
	
func get_current_level_index() -> int:
	return current_level_index
