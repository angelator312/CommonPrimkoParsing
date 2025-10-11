@abstract class_name CommonGameObject

# How to add new game object
# - Name:the name of the game object, but in PascalCase (like Checkpoint)
# - name:Name but in snake_case (like checkpoint)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("name"):
		_from_string(object_str, root)
		return true
	return false


static func _from_string(encodedObject: String, root: Node2D):
	MyLogger.obj("name:", encodedObject)
	encodedObject = encodedObject.trim_prefix("name type=\"Name\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	MyLogger.props(props)
	_add_node(props, root)


static func _add_node(properties: Dictionary[String, Variant], root: Node2D):
	#var node: Node2D = CommonLoadFormat1.config.NameScene.instantiate()
	#print("name name:", node.name) # Only for debug purposes
	#CommonLoadFormat1.add_child(node, root, properties)
	pass
