#This script has the main functionality required for the Yoga Activity. It does:
#1. Emits signals to connected YogaCat script to start animations
#2. Maintains a timer& Displays next screen when it is done
#3. Handles the next button click
#4. Maintains a timer as a buffer/prep time before starting animation

extends CanvasLayer

export var TotalNumberOfSeconds = 15

signal activityOver
signal beginAnimation
var TimerString

var timerCount = 0
var activeTimer = false
var halfCycleReached = false
var numOfSeconds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TimerString = $TimerBG/Timer
	TimerString.text = str(TotalNumberOfSeconds)
	timerCount = TotalNumberOfSeconds

# Function acts as a bridge for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://tilli.teqbahn.com/tilli-web/godot-redirect")'))
	get_tree().quit()

#This function runs every frame and is responsible
func _process(delta):
	if activeTimer:
		timerCount -= delta #Countdown Timer when the activeTimer is True
		if numOfSeconds != ceil(timerCount):
			numOfSeconds = ceil(timerCount)
			TimerString.text = str(numOfSeconds) #Update the UI if the timer changed by one second
		
		#When the timer runsout emit a signal activityOver to stop animations and display Next button
		if timerCount < 0:
			activeTimer = false
			$TimerBG.hide() #Hide timer
			$Next.show() #Show the button that allows user to go to next
			emit_signal("activityOver") #Emit signal so the Cat script connected to it stops the animation
			
	
#This function gets called by the signal from the child timer that allows plaayers to have a buffer timer of 2 seconds before starting
func _on_HideInstructionsTimer_timeout():
	$StartingInstuction.text = "Do it with me!" #Update the text to follow the pose
	activeTimer = true #Start counter in the _process inbuilt function
	emit_signal("beginAnimation") #Emit signal to the YogaCat script starts the animations
	

