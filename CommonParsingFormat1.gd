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
	
	return ""


static func quadrant_from_string(encodedQuadrant: String, root: Node2D):
	print("quadrant:", encodedQuadrant)
	encodedQuadrant = encodedQuadrant.trim_prefix("quadrant type=\"Quadrant\"]\n")
	var props = split_props(encodedQuadrant)
	print("props:", props)
	CommonLoadFormat1.add_quadrant(props, root)


static func checkpoint_from_string(encodedCheckpoint: String, root: Node2D):
	print("checkpoint:", encodedCheckpoint)
	encodedCheckpoint = encodedCheckpoint.trim_prefix("checkpoint type=\"Checkpoint\"]\n")
	var props = split_props(encodedCheckpoint)
	print("props:", props)
	CommonLoadFormat1.add_checkpoint(props, root)


static func enemy_from_string(encodedEnemy: String, root: Node2D):
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
	CommonLoadFormat1.add_enemy(type, props, root)


static func coin_from_string(encodedCoin: String, root: Node2D):
	print("coin:", encodedCoin)
	encodedCoin = encodedCoin.trim_prefix("coin type=\"Coin\"]\n")
	var props = split_props(encodedCoin)
	print("props:", props)
	CommonLoadFormat1.add_coin(props, root)


static func artefact_from_string(encodedEnemy: String, root: Node2D):
	print("artefact:", encodedEnemy)
	encodedEnemy = encodedEnemy.trim_prefix("artefact type=")
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
	CommonLoadFormat1.add_artefact(type, props, root)


static func make_tree_from_string(str: String, root: Node2D):
	if !str.begins_with("[level"):
		print("You try to load not a level file!")
		return
	var split_str = str.split("[", false)
	for object_str in split_str:
		if object_str.begins_with("enemy"):
			enemy_from_string(object_str, root)
		if object_str.begins_with("quadrant"):
			quadrant_from_string(object_str, root)
		if object_str.begins_with("coin"):
			coin_from_string(object_str, root)
		if object_str.begins_with("artefact"):
			artefact_from_string(object_str, root)
		if object_str.begins_with("checkpoint"):
			checkpoint_from_string(object_str, root)


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

# Add another parsing functions ↑↑↑
