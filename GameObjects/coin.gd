extends CommonGameObject
# How to add new game object
# - Coin:the name of the game object, but in PascalCase (like `Checkpoint`)
# - coin:Coin but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("coin"):
		from_string(object_str, root)
		return true
	return false


static func from_string(encodedObject: String, root: Node2D):
	MyLogger.obj("coin:", encodedObject)
	encodedObject = encodedObject.trim_prefix("coin type=\"Coin\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	MyLogger.props(props)
	add_node(props, root)


static func add_node(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = CommonLoadFormat1.config.CoinScene.instantiate()
	CommonLoadFormat1.add_child(node, root, properties)
