extends CommonGameObject

# How to add new game object
# - Quadrant:the name of the game object, but in PascalCase (like `Checkpoint`)
# - quadrant:Quadrant but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("quadrant"):
		from_string(object_str, root)
		return true
	return false

static func from_string(encodedObject: String, root: Node2D):
	print("quadrant:", encodedObject)
	encodedObject = encodedObject.trim_prefix("quadrant type=\"Quadrant\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	print("props:", props)
	add_node(props, root)

static func add_node(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = CommonLoadFormat1.config.QuadrantScene.instantiate()
	print("quadrant name:", node.name) # Only for debug purposes
	CommonLoadFormat1.add_child(node, root, properties)
	pass
