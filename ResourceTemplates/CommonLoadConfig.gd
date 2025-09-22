class_name CommonLoadConfig extends Resource

@export var enemiesScenes: Dictionary[String, PackedScene]
#= {
#	"Walker": preload("res://Enemies/Walker.tscn"),
#}

@export var QuadrantScene: PackedScene # = preload("res://LevelEditor/quadrant.tscn")

@export var CoinScene: PackedScene

func _init(_enemiesScenes: Dictionary[String, PackedScene], quadrantScene: PackedScene, coinScene: PackedScene) -> void:
	enemiesScenes = _enemiesScenes
	QuadrantScene = quadrantScene
	CoinScene = coinScene
