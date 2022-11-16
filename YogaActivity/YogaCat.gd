#This script's main function is to assign a random yoga animation everytime

extends Node

export var NumberOfAnimations = 4
var randomKey

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #To ensure that ever time the game runs the output is different
	randomKey = randi() % NumberOfAnimations #Storing the random variable
	
#Connected to a signal on HUD that gets emitted when the initial timer runs out
#We set the animation based on the key generated at the start and play it
func _on_HUD_timerStarted_beginAnimation():
	if randomKey == 0:
		 $AnimatedSprite.play("pose1")
	if randomKey == 1:
		$AnimatedSprite.play("pose2")
	if randomKey == 2:
		$AnimatedSprite.play("pose3")
	if randomKey == 3:
		$AnimatedSprite.play("pose4")

#This function is connect to a signal on HUD what gets emitted when main timer runs out and stop animation
func _on_HUD_yoga_activityOver():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()
