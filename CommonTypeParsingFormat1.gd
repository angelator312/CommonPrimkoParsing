class_name CommonTypeParsingFormat1

static func parse_property(s: String) -> Variant:
	if s.begins_with("Vector2"):
		return parse_vector2_string(s)
	
	if s.begins_with("Bool"):
		return parse_bool_string(s)
	
	if s.begins_with("NodePath"):
		return parse_node_path_string(s)
	
	if s.begins_with("PackedByteArray"):
		s = s.trim_prefix("PackedByteArray(").trim_suffix(")")
		var str_split = s.split(",")
		var arr: Array = []
		for e in str_split:
			arr.append(int(e))
		var vec: PackedByteArray = PackedByteArray(arr).decompress(LevelEditorTypes.MAX_BUFFER_SIZE, LevelEditorTypes.QUDRANT_COMPRESS)
		return vec
	
	if s.begins_with("Array<Vector2>"):
		s = s.trim_prefix("Array<Vector2>(").trim_suffix(")")
		return parse_array_of_vector2(s)
	
	if s.begins_with("TileMapLayerFunctions"):
		return TileMapLayerFunctions.parse_tile_map_layer_functions(s)
	
	if s.begins_with("Shape2D<WorldBoundary>"):
		s = s.trim_prefix("Shape2D<WorldBoundary>(").trim_suffix(")")
		return parse_world_boundary_shape(s)
	return ""


static func parse_vector2_string(s: String) -> Vector2:
	s = s.trim_prefix("Vector2(").trim_suffix(")")
	var str_split = s.split(",")
	var vec: Vector2 = Vector2(float(str_split[0]), float(str_split[1]))
	return vec


static func parse_bool_string(s: String) -> bool:
	s = s.trim_prefix("Bool(").trim_suffix(")")
	return s == "true"


static func parse_node_path_string(s: String) -> NodePath:
	s = s.trim_prefix("NodePath(").trim_suffix(")")
	return NodePath(s)


static func parse_array_of_vector2(s: String):
	var str_split = s.split(",", false)
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


static func parse_world_boundary_shape(s: String):
	var split_s: PackedStringArray = s.split(";", false)
	assert(split_s.size() == 3, "%s is not valid world boundary string" % [s])
	var out: WorldBoundaryShape2D = WorldBoundaryShape2D.new()
	out.normal = parse_vector2_string(split_s[0])
	out.distance = split_s[1].to_float()
	out.custom_solver_bias = split_s[2].to_float()
	return out

# Add new parse_* functions ↓↓↓
