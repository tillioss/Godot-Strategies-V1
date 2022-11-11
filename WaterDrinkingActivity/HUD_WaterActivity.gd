

extends CanvasLayer

export var TotalNumberOfSeconds = 20

signal activityOver
var timeLeftString

var currentNumberOfSeconds
var floatTime

var isTimerActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timeLeftString = $TimerBG/TimeLeft 
	timeLeftString.text = str(TotalNumberOfSeconds) 
	currentNumberOfSeconds = TotalNumberOfSeconds
	floatTime = TotalNumberOfSeconds
	
func _process(delta):
	if isTimerActive:
		floatTime -= delta
		if currentNumberOfSeconds != ceil(floatTime):
			currentNumberOfSeconds = ceil(floatTime)
			timeLeftString.text = str(currentNumberOfSeconds)
		if currentNumberOfSeconds <= 0:
			$TimerBG.hide()
			$Next.show() 
			emit_signal("activityOver") #Emit signal to stop 
			$StartingInstuction.hide()
			$Continue.show()
			$TilliHugging.stop()
			isTimerActive = false

# Supposedly developed for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp, for now it goes to Tilli website as a test
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()


#Hiding the initial instructions after the child timer runs out
func _on_HideInstructionsTimer_timeout():
	$StartingInstuction.text = "Hugs help reduce\nstress"
	isTimerActive = true
	$TilliHugging.play("default")

