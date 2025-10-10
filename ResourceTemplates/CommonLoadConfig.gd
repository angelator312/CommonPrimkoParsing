class_name CommonLoadConfig extends Resource

@export var enemiesScenes: Dictionary[String, PackedScene]
#= {
#	"Walker": preload("res://Enemies/Walker.tscn"),
#}

@export var artefactsScenes: Dictionary[String, PackedScene]

@export var QuadrantScene: PackedScene # = preload("res://LevelEditor/quadrant.tscn")

@export var CoinScene: PackedScene

@export var CheckpointScene: PackedScene

@export var PlayerScene: PackedScene

@export var HUDLayerScene: PackedScene

@export var WorldBorderScene: PackedScene

@export var gameObjectsDirectory: String

func _init(_enemiesScenes: Dictionary[String, PackedScene], _artefactsScenes: Dictionary[String, PackedScene], quadrantScene: PackedScene, coinScene: PackedScene) -> void:
	enemiesScenes = _enemiesScenes
	artefactsScenes = _artefactsScenes
	QuadrantScene = quadrantScene
	CoinScene = coinScene
