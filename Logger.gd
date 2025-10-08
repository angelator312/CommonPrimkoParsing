class_name MyLogger
static var IS_DEBUG_PRINTED = true
static var IS_PROP_PRINTED = true
static var ARE_AVAILBLE_GAME_OBJECTS_PRINTED = true
static var ARE_ALL_PROPS_PRINTED = true
# debug print
static func d(...args):
	if IS_DEBUG_PRINTED:
		print(args)

# prints one prop
static func p(prop: String, prop_value: Variant):
	if IS_PROP_PRINTED:
		d("prop:", prop, " ", prop_value)

static func e(...args):
	printerr(args)

static func objs(a: Array):
	if ARE_AVAILBLE_GAME_OBJECTS_PRINTED:
		d("objects:", a)

static func props(p: Dictionary[String, Variant]):
	if ARE_ALL_PROPS_PRINTED:
		d("props2:", p)