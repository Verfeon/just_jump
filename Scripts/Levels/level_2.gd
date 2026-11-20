extends Node2D

@onready var map: TileMapLayer = $Map


func open_wall():
	var tiles1 = [23, 4]
	var tiles2 = [25, 4]
	var tiles = []
	
	for i in range(tiles1[0], tiles2[0] + 1):
		for j in range(tiles1[1], tiles2[1] + 1):
			tiles.append(Vector2i(i, j))
			
	map.set_cells_terrain_connect(tiles, 0, -1)
