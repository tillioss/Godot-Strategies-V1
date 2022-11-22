extends Node2D

export(Array, PackedScene) var AllStrategyScenes

# Called when the node enters the scene tree for the first time.
func _ready():
	var time = Time.get_date_dict_from_system(false)
	#OS.get_datetime()
	var date = time["day"]
	var dateCode = date % AllStrategyScenes.size()
	SetSceneBasedOnDate(dateCode)
	
func SetSceneBasedOnDate(var dateCode):
	get_tree().change_scene_to(AllStrategyScenes[dateCode])
	
	


