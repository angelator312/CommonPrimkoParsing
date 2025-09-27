class_name TileMapLayerFunctions

# Every vector is const simpler_platform_terrain_set, simpler_platform_terrain, platform_terrain_set, platform_terrain

const terrainConfigs: Array[Vector4i] = [
	Vector4i(0, 0, 0, 0),
]

enum TypesOFTileMapLayerFunctions {PLATFORM}


class TileMapLayerFunc:
	var type: TypesOFTileMapLayerFunctions
	var params: Array[Variant]


static func parse_tile_map_layer_functions(str: String) -> Array[TileMapLayerFunc]:
	str = str.trim_prefix("TileMapLayerFunctions(").trim_suffix(")")
	var functions: Array[TileMapLayerFunc] = []
	var split_str = str.split(";", false)
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
	print("params of platform func:", params)
	var cells: Array[Vector2i] = get_cells(params[0], params[1], params[0] + params[2], params[1] + params[3])
	var terrainObject = terrainConfigs[params[4] - 1]
	if params[3] == 0:
		if !cells.is_empty():
			print("empty cells")
		print("set_cells:", cells[0])
		for tile in cells:
			tile_map_layer.set_cell(tile, 1, Vector2i(0, 0))


static func get_cells(minX: int, minY: int, maxX: int, maxY: int) -> Array[Vector2i]:
	var cells: Array[Vector2i] = []
	for x in range(minX, maxX + 1):
		for y in range(minY, maxY + 1):
			cells.push_back(Vector2i(x, y))
	return cells
