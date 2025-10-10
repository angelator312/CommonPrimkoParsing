class_name TileMapLayerFunctions

# Every vector is const simpler_platform_terrain_set, simpler_platform_terrain, platform_terrain_set, platform_terrain

const terrainConfigs: Array[Vector4i] = [
	Vector4i(0, 1, 0, 2),
]

enum TypesOFTileMapLayerFunctions {PLATFORM}


class TileMapLayerFunc:
	var type: TypesOFTileMapLayerFunctions
	var params: Array[Variant]


static func parse_tile_map_layer_functions(s: String) -> Array[TileMapLayerFunc]:
	s = s.trim_prefix("TileMapLayerFunctions(").trim_suffix(")")
	var functions: Array[TileMapLayerFunc] = []
	var split_str = s.split(";", false)
	for now_str in split_str:
		var function = TileMapLayerFunc.new()
		if now_str.begins_with("P("):
			function.type = TypesOFTileMapLayerFunctions.PLATFORM
			now_str = now_str.trim_prefix("P(").trim_suffix(")")
		for e in now_str.split(",", false):
			function.params.push_back(e.to_int())
		functions.push_back(function)
	return functions


static func run_tile_map_layer_func(function: TileMapLayerFunc, tile_map_layer: TileMapLayer):
	if function.type == TypesOFTileMapLayerFunctions.PLATFORM:
		run_platform_func(function.params, tile_map_layer)


static func run_platform_func(params: Array, tile_map_layer: TileMapLayer):
	var cells: Array[Vector2i] = get_cells(params[0], params[1], params[0] + params[2], params[1] + params[3])
	var terrainObject = terrainConfigs[params[4] - 1]
	var terrain_set: int
	var terrain_in_terrain_set: int
	if params[3] == 0:
		terrain_set = terrainObject.x
		terrain_in_terrain_set = terrainObject.y
	elif params[3] > 0:
		terrain_set = terrainObject.z
		terrain_in_terrain_set = terrainObject.w

	for tile in cells:
		tile_map_layer.set_cell(tile, 1, Vector2i(0, 0))
	tile_map_layer.set_cells_terrain_connect(cells, terrain_set, terrain_in_terrain_set)


static func get_cells(minX: int, minY: int, maxX: int, maxY: int) -> Array[Vector2i]:
	var cells: Array[Vector2i] = []
	for x in range(minX, maxX + 1):
		for y in range(minY, maxY + 1):
			cells.push_back(Vector2i(x, y))
	return cells


static func get_tile_map_data_property(node: TileMapLayer) -> String:
	var usedTilesCoordinates: Array[Vector2i] = node.get_used_cells()
	var str = ""
	var usedTiles: Dictionary[Vector2i, bool] = {}
	var i = 0
	for tile in usedTilesCoordinates:
		if usedTiles.get(tile): continue
		usedTiles.get_or_add(tile, true)
		var neighbors: Array[Vector2i] = get_neighboring_used_cells(node, tile, usedTiles)
		var rect = getRect(neighbors)
		var cell_source_id = node.get_cell_source_id(tile)
		str = (str + "P(%d,%d,%d,%d,%d);") % [rect.position.x, rect.position.y, rect.size.x, rect.size.y, cell_source_id]
	
	# print("cells:", str)
	return "tile_map_data=TileMapLayerFunctions(%s)" % [str]

static func get_neighboring_used_cells(node: TileMapLayer, tile: Vector2i, usedTiles: Dictionary[Vector2i, bool]) -> Array[Vector2i]:
	var arr: Array[Vector2i] = []
	var queue: Array[Vector2i] = []
	var cell_source_id = node.get_cell_source_id(tile)
	queue.push_back(tile)
	arr.push_back(tile)
	while !queue.is_empty():
		var now = queue.back()
		queue.pop_back()
		for cell in node.get_surrounding_cells(now):
			if usedTiles.get(cell) != null:
				continue
			usedTiles.get_or_add(cell, true)
			if node.get_cell_source_id(cell) == cell_source_id:
				arr.push_back(cell)
				queue.push_back(cell)
	return arr


static func getMinMax(arr: Array[Vector2i]) -> Rect2i:
	var mn = Vector2i(arr[0].x, arr[0].y);
	var mx = Vector2i(arr[0].x, arr[0].y);
	for e in arr:
		mn.x = min(e.x, mn.x)
		mn.y = min(e.y, mn.y)
		mx.x = max(e.x, mx.x)
		mx.y = max(e.y, mx.y)
	return Rect2i(mn, mx);


static func getRect(arr: Array[Vector2i]) -> Rect2i:
	var rect = getMinMax(arr)
	rect.size.x -= rect.position.x
	rect.size.y -= rect.position.y
	return rect;
