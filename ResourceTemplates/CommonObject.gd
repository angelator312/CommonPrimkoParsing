@abstract class_name CommonGameObject

# How to add new game object
# - `Name`:the name of the game object, but in PascalCase (like `Checkpoint`)
# - `name`:`Name` but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("`name`"):
		from_string(object_str, root)

static func from_string(encodedObject: String, root: Node2D):
	print("`name`:", encodedObject)
	encodedObject = encodedObject.trim_prefix("`name` type=\"`Name`\"]\n")
	var props = CommonParsingFormat1.split_props(encodedObject)
	print("props:", props)
	add_node(props, root)

static func add_node(properties: Dictionary[String, Variant], root: Node2D):
	# var node: Node2D = config.`Name`Scene.instantiate()
	# print("`name` name:", node.name) # Only for debug purposes
	# add_child(node, root, properties)
	pass
