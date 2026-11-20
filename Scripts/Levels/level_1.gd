extends Node2D

@onready var map: TileMapLayer = $Map
@onready var arrows: Node2D = $TutorialArrows



func open_wall():
	var tiles1 = [19, 6]
	var tiles2 = [21, 9]
	var tiles = []
	
	for i in range(tiles1[0], tiles2[0] + 1):
		for j in range(tiles1[1], tiles2[1] + 1):
			tiles.append(Vector2i(i, j))
			
	map.set_cells_terrain_connect(tiles, 0, -1)
	
	
func _on_lever_actionned():
	open_wall()
	arrows.visible = false
