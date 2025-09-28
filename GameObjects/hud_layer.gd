extends CommonGameObject

# How to add new game object
# - HUDLayer:the name of the game object, but in PascalCase (like `Checkpoint`)
# - hud_layer:HUDLayer but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("hud_layer"):
		_from_string(object_str, root)
		return true
	return false

static func _from_string(encodedObject: String, root: Node2D):
	print("hud_layer:", encodedObject)
	encodedObject = encodedObject.trim_prefix("hud_layer type=\"HUDLayer\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	print("props:", props)
	_add_node(props, root)

static func _add_node(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node = CommonLoadFormat1.config.HUDLayerScene.instantiate()
	print("hud_layer name:", node.name) # Only for debug purposes
	CommonLoadFormat1.add_child(node, root, properties)
