# How to add new game object
# - Artefact:the name of the game object, but in PascalCase (like `Checkpoint`)
# - artefact:Artefact but in snake_case (like `checkpoint`)

static func load(object_str: String, root: Node2D):
	if object_str.begins_with("artefact"):
		_from_string(object_str, root)
		return true
	return false

static func _from_string(encodedEnemy: String, root: Node2D):
	MyLogger.obj("artefact:", encodedEnemy)
	encodedEnemy = encodedEnemy.trim_prefix("artefact type=")
	var type = ""
	for e in encodedEnemy:
		if e == "]":
			break
		type += e
	encodedEnemy = encodedEnemy.trim_prefix(type).trim_prefix("]\n")
	type = type.trim_prefix("\"").trim_suffix("\"")
	MyLogger.d(type)
	var props: Dictionary[String, Variant] = CommonParsingFormat1.split_props(encodedEnemy)
	MyLogger.props(props)
	_add_node(type, props, root)

static func _add_node(type: String, properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = CommonLoadFormat1.config.artefactsScenes.get(type).instantiate()
	CommonLoadFormat1.add_child(node, root, properties)
