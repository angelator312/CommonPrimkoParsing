class_name CommonLoadConfig extends Resource

@export var enemiesScenes: Dictionary[String, PackedScene]
#= {
#	"Walker": preload("res://Enemies/Walker.tscn"),
#}

@export var quadrantScene: PackedScene # = preload("res://LevelEditor/quadrant.tscn")

func _init(_enemiesScenes: Dictionary[String, PackedScene], _quadrantScene: PackedScene) -> void:
	enemiesScenes = _enemiesScenes
	quadrantScene = _quadrantScene
