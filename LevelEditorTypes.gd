class_name LevelEditorTypes

enum PropertyTypes {
	POSITION = 0,
	TILE_MAP_DATA,
	CURVE_POINTS,
	IS_SECOND,
	PLAYER_PARTICLES_GROUP_PATH,
	PLAYER_PATH,
	END_PATH,
	SHAPE,
	CAMERA_LIMITS,
	# Add a new property ↑↑↑
}

const QUDRANT_COMPRESS: FileAccess.CompressionMode = FileAccess.COMPRESSION_FASTLZ
const MAX_BUFFER_SIZE: int = int(1e5)
const ARG_FOR_STARTING_LEVEL: String = "--start-level-path"
