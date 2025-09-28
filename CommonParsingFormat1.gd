class_name CommonParsingFormat1

static func set_properties_of_object(node: Node, properties: Dictionary[String, Variant]):
	for prop in properties:
		print("prop:", prop, " ", properties[prop])
		match prop:
			"position":
				node.global_position = properties[prop]
			"curve_points":
				node.curve = Curve2D.new()
				for e in properties[prop]:
					node.curve.add_point(e)
			"tile_map_data":
				assert(node is TileMapLayer, "Node need to be tile map layer")
				if (node is TileMapLayer):
					for now_func in properties[prop]:
						TileMapLayerFunctions.run_tile_map_layer_func(now_func, node)
			_:
				node.set(prop, properties[prop])


static func split_props(stringifiedProps: String) -> Dictionary[String, Variant]:
	var out: Dictionary[String, Variant]
	var props = stringifiedProps.split("\n", false)
	for prop in props:
		var split_prop = prop.split("=")
		var property = split_prop[0]
		var prop_value = CommonTypeParsingFormat1.parse_property(split_prop[1])
		out.get_or_add(property, prop_value)
	return out


static func load_all_scripts_in_folder(folder_path: String) -> Array[Resource]:
	var scripts: Array[Resource] = []
	var dir = DirAccess.open(folder_path)
	if dir == null:
		return scripts
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".gd"):
			var script_path = folder_path.path_join(file_name)
			var script = ResourceLoader.load(script_path, "", ResourceLoader.CACHE_MODE_IGNORE)
			if script:
				scripts.append(script)
		file_name = dir.get_next()
	dir.list_dir_end()
	return scripts


static func make_tree_from_string(str: String, root: Node2D):
	if !str.begins_with("[level"):
		print("You try to load not a level file!")
		return
	var split_str: PackedStringArray = str.split("[", false)
	var objects: Array = load_all_scripts_in_folder(CommonLoadFormat1.config.gameObjectsDirectory)
	print("objects:", objects)
	for object_str in split_str:
		for object in objects:
			if object.load(object_str, root):
				break


static func player_from_string(encodedPlayer: String, root: Node2D):
	print("player:", encodedPlayer)
	encodedPlayer = encodedPlayer.trim_prefix("player type=\"Player\"]\n")
	var props = split_props(encodedPlayer)
	print("props:", props)
	CommonLoadFormat1.add_player(props, root)


static func hud_layer_from_string(encodedHUDLayer: String, root: Node2D):
	print("hud_layer:", encodedHUDLayer)
	encodedHUDLayer = encodedHUDLayer.trim_prefix("hud_layer type=\"HUDLayer\"]\n")
	var props = split_props(encodedHUDLayer)
	print("props:", props)
	CommonLoadFormat1.add_hud_layer(props, root)
