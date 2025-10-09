# How to add new game object
# - Enemy:the name of the game object, but in PascalCase (like `Checkpoint`)
# - enemy:Enemy but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("enemy"):
		from_string(object_str, root)
		return true
	return false


static func from_string(encodedEnemy: String, root: Node2D):
	MyLogger.obj("enemy:", encodedEnemy)
	encodedEnemy = encodedEnemy.trim_prefix("enemy type=")
	var type = ""
	for e in encodedEnemy:
		if e == "]":
			break
		type += e
	encodedEnemy = encodedEnemy.trim_prefix(type).trim_prefix("]\n")
	type = type.trim_prefix("\"").trim_suffix("\"")
	MyLogger.d(type)
	var props = CommonParsingFormat1.split_props(encodedEnemy)
	MyLogger.props( props)
	add_node(type, props, root)


static func add_node(type:String,properties: Dictionary[String, Variant], root: Node2D):
	print("enemy scenes:", CommonLoadFormat1.config.enemiesScenes)
	var node: Node2D = CommonLoadFormat1.config.enemiesScenes.get(type).instantiate()
	CommonLoadFormat1.add_child(node, root, properties)
	pass
