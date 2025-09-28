class_name CommonTypeParsingFormat1

static func parse_property(str: String) -> Variant:
	if str.begins_with("Vector2"):
		return parse_vector2_string(str)
	
	if str.begins_with("Bool"):
		return parse_bool_string(str)
	
	if str.begins_with("NodePath"):
		return parse_node_path_string(str)
	
	if str.begins_with("PackedByteArray"):
		str = str.trim_prefix("PackedByteArray(").trim_suffix(")")
		var str_split = str.split(",")
		var arr: Array = []
		for e in str_split:
			arr.append(int(e))
		var vec: PackedByteArray = PackedByteArray(arr).decompress(LevelEditorTypes.MAX_BUFFER_SIZE, LevelEditorTypes.QUDRANT_COMPRESS)
		return vec
	
	if str.begins_with("Array<Vector2>"):
		str = str.trim_prefix("Array<Vector2>(").trim_suffix(")")
		var str_split = str.split(",", false)
		var arr: Array[Vector2] = []
		var prev: float = INF
		for e: String in str_split:
			e = e.trim_prefix(" ").trim_prefix("(")
			e = e.trim_suffix(" ").trim_suffix(")")
			if prev != INF:
				arr.append(Vector2(prev, float(e)))
				prev = INF
			else:
				prev = float(e)
		return arr
	
	if str.begins_with("TileMapLayerFunctions"):
		return TileMapLayerFunctions.parse_tile_map_layer_functions(str)
	
	return ""


static func parse_vector2_string(str: String) -> Vector2:
	str = str.trim_prefix("Vector2(").trim_suffix(")")
	var str_split = str.split(",")
	var vec: Vector2 = Vector2(float(str_split[0]), float(str_split[1]))
	return vec


static func parse_bool_string(str: String) -> bool:
	str = str.trim_prefix("Bool(").trim_suffix(")")
	return str == "true"


static func parse_node_path_string(str: String) -> NodePath:
	str = str.trim_prefix("NodePath(").trim_suffix(")")
	return NodePath(str)


# Add new parse_* functions ↓↓↓
