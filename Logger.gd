class_name MyLogger

static var IS_DEBUG_PRINTED: bool = true
static var IS_OBJECT_STRING_PRINTED: bool = true
static var IS_PROP_PRINTED: bool = true
static var ARE_AVAILBLE_GAME_OBJECTS_PRINTED: bool = true
static var ARE_ALL_PROPS_PRINTED: bool = true

# debug print
static func d(...args):
	if IS_DEBUG_PRINTED:
		print.callv(args)

# prints one prop
static func p(prop: String, prop_value: Variant):
	if IS_PROP_PRINTED:
		d("prop:", prop, " ", prop_value)


static func e(...args):
	printerr.callv(args)


static func objs(a: Array):
	if ARE_AVAILBLE_GAME_OBJECTS_PRINTED:
		d("objects:", a)

static func props(prs: Dictionary[String, Variant]):
	if ARE_ALL_PROPS_PRINTED:
		d("props:", prs)


static func obj(name: String, encodedObject: String):
	if IS_OBJECT_STRING_PRINTED:
		print()
		print(name, encodedObject.strip_edges())


static func mute():
	_set_all_to(false)


static func unmute():
	_set_all_to(true)


static func _set_all_to(x: bool):
	IS_DEBUG_PRINTED = x
	IS_OBJECT_STRING_PRINTED = x
	IS_PROP_PRINTED = x
	ARE_AVAILBLE_GAME_OBJECTS_PRINTED = x
	ARE_ALL_PROPS_PRINTED = x
