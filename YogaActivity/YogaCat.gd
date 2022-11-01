extends Node

export var NumberOfAnimations = 4
var randomKey
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	randomKey = randi() % NumberOfAnimations
	#print("Animation random key: " + str(randomKey))
	

func _on_HUD_timerStarted_beginAnimation():
	if randomKey == 0:
		 $AnimatedSprite.play("pose1")
	if randomKey == 1:
		$AnimatedSprite.play("pose2")
	if randomKey == 2:
		$AnimatedSprite.play("pose3")
	if randomKey == 3:
		$AnimatedSprite.play("pose4")


func _on_HUD_yoga_activityOver():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()
