# How to add new game object
# - WorldBorder:the name of the game object, but in PascalCase (like Checkpoint)
# - world_border:WorldBorder but in snake_case (like checkpoint)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("world_border"):
		_from_string(object_str, root)
		return true
	return false


static func _from_string(encodedObject: String, root: Node2D):
	MyLogger.obj("world_border:", encodedObject)
	encodedObject = encodedObject.trim_prefix("world_border type=\"WorldBorder\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	MyLogger.props(props)
	_add_node(props, root)


static func _add_node(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = CommonLoadFormat1.config.WorldBorderScene.instantiate()
	CommonLoadFormat1.add_child(node, root, properties)
