class_name CommonLoadFormat1

static var config: CommonLoadConfig

static func delete_all_children_recursive(root: Node):
	for node in root.get_children():
		delete_all_children_recursive(node)
		if node.name.is_valid_int():
			node.free()


static func load(_level_name: String, path: String, root: Node2D, _config: CommonLoadConfig):
	config = _config
	delete_all_children_recursive(root)
	var file_contents = FileAccess.get_file_as_string(path)
	CommonParsingFormat1.make_tree_from_string(file_contents, root)


static func add_quadrant(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = config.QuadrantScene.instantiate()
	print("quadrant name:", node.name)
	add_child(node, root, properties)


static func add_checkpoint(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = config.CheckpointScene.instantiate()
	print("checkpoint name:", node.name)
	add_child(node, root, properties)


static func add_coin(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = config.CoinScene.instantiate()
	print("coin name:", node.name)
	add_child(node, root, properties)


static func add_enemy(type: String, properties: Dictionary[String, Variant], root: Node2D):
	print("scenes:", config.enemiesScenes)
	var node: Node2D = config.enemiesScenes.get(type).instantiate()
	add_child(node, root, properties)


static func add_artefact(type: String, properties: Dictionary[String, Variant], root: Node2D):
	print("artefact scenes:", config.artefactsScenes)
	var node: Node2D = config.artefactsScenes.get(type).instantiate()
	add_child(node, root, properties)


static func add_hud_layer(properties: Dictionary[String, Variant], root: Node2D):
	var node: CanvasLayer = config.HUDLayerScene.instantiate()
	print("hud_layer name:", node.name) # Only for debug purposes
	add_child(node, root, properties)


static func add_child(node, root, properties: Dictionary[String, Variant]):
	add_object_as_a_child(node, root)
	CommonParsingFormat1.set_properties_of_object(node, properties)


static func add_object_as_a_child(enemy: Node, root: Node2D):
	var par = root.get_node_or_null(NodePath(enemy.name))
	if par == null || par.is_queued_for_deletion():
		par = Node2D.new()
		par.name = enemy.name
		root.add_child(par)
		par.owner = root
	par.name = enemy.name
	enemy.name = str(par.get_child_count())
	par.add_child(enemy)
	enemy.owner = root


static func add_player(properties: Dictionary[String, Variant], root: Node2D):
	var node: Node2D = config.PlayerScene.instantiate()
	print("player name:", node.name)
	add_child(node, root, properties)
