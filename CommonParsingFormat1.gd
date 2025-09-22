class_name CommonParsingFormat1

static func set_properties_of_object(node: Node2D, properties: Dictionary[String, Variant]):
	for prop in properties:
		print("prop:", prop, " ", properties[prop])
		match prop:
			"position":
				node.global_position = properties[prop]
			"curve_points":
				node.curve = Curve2D.new()
				for e in properties[prop]:
					node.curve.add_point(e)
			_:
				node.set(prop, properties[prop])


static func split_props(stringifiedProps: String) -> Dictionary[String, Variant]:
	var out: Dictionary[String, Variant]
	var props = stringifiedProps.split("\n", false)
	for prop in props:
		var split_prop = prop.split("=")
		var property = split_prop[0]
		var prop_value = parse_property(split_prop[1])
		out.get_or_add(property, prop_value)
	return out
		

static func parse_property(str: String) -> Variant:
	if str.begins_with("Vector2"):
		str = str.trim_prefix("Vector2(").trim_suffix(")")
		var str_split = str.split(",")
		var vec: Vector2 = Vector2(float(str_split[0]), float(str_split[1]))
		return vec
	if str.begins_with("PackedByteArray"):
		str = str.trim_prefix("Vector2(").trim_suffix(")")
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
	return ""


static func quadrant_from_string(encodedQuadrant: String, root: Node2D, add_quadrant_func: Callable):
	print("quadrant:", encodedQuadrant)
	encodedQuadrant = encodedQuadrant.trim_prefix("quadrant type=\"Quadrant\"]\n")
	var props = split_props(encodedQuadrant)
	print("props:", props)
	add_quadrant_func.call(props, root)


static func enemy_from_string(encodedEnemy: String, root: Node2D, add_enemy: Callable):
	print("enemy:", encodedEnemy)
	encodedEnemy = encodedEnemy.trim_prefix("enemy type=")
	var type = ""
	for e in encodedEnemy:
		if e == "]":
			break
		type += e
	encodedEnemy = encodedEnemy.trim_prefix(type).trim_prefix("]\n")
	type = type.trim_prefix("\"").trim_suffix("\"")
	print(type)
	var props = split_props(encodedEnemy)
	print("props:", props)
	add_enemy.call(type, props, root)
