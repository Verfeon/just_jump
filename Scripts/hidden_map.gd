extends TileMapLayer

@export var player: CharacterBody2D = null

func _process(_delta: float) -> void:
	if not material or not player:
		print("problem")
		return

	# Convertit la position globale du joueur en coordonnées de viewport (pixels)
	var screen_pos: Vector2 = get_viewport().get_canvas_transform() * player.global_position
	material.set_shader_parameter("player_pos", screen_pos)


func _get_configuration_warning() -> String:
	if player == null:
		return "⚠ Le player n'est pas assigné ! Le shader de révélation ne fonctionnera pas."
	return "test"
