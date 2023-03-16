extends Node2D

var AllScenesList
export(PackedScene) var BubblePopActivity
export(PackedScene) var ColoringActivity
export(PackedScene) var SelfHugActivity
export(PackedScene) var RainbowActivity
export(PackedScene) var WaterDrinkingActivity
export(PackedScene) var YogaActivity

# Called when the node enters the scene tree for the first time.
func _ready():
	PopulateScenesList()
	SetSceneBasedOnURLorRandom()
	
func SetSceneBasedOnURLorRandom():
	var chosenActivity = GetActivityName()
	match chosenActivity:
		"BubblePopActivity":
			get_tree().change_scene_to(BubblePopActivity)
		"YogaActivity":
			get_tree().change_scene_to(YogaActivity)
		"ColoringActivity":
			get_tree().change_scene_to(ColoringActivity)
		"RainbowActivity":
			get_tree().change_scene_to(RainbowActivity)
		"SelfHugActivity":
			get_tree().change_scene_to(SelfHugActivity)
		"WaterDrinkingActivity":
			get_tree().change_scene_to(WaterDrinkingActivity)
		_:
			#Default Date based scene triggering
			get_tree().change_scene_to(GetDateBasedActivityName())
			#Default Random scene triggering
			#get_tree().change_scene_to(GetRandomActivityName())
	
func PopulateScenesList():
	AllScenesList = [YogaActivity, BubblePopActivity, 
	RainbowActivity, WaterDrinkingActivity, 
	ColoringActivity, SelfHugActivity]
	print_debug(AllScenesList)
	
func GetActivityName():
	var activityName = ""
	if OS.has_feature('JavaScript'):
		 activityName = JavaScript.eval("""
			var url_string = window.location.href;
			var url = new URL(url_string);
			url.searchParams.get("activity");
			""")
	#print_debug(activityName);
	return activityName
		
func GetRandomActivityName():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return AllScenesList[rng.randi_range(0, AllScenesList.size()-1)]
	
func GetDateBasedActivityName():
	var time = Time.get_date_dict_from_system(false)
	var date = time["day"]
	var dateCode = date % AllScenesList.size()
	return AllScenesList[dateCode]
