#This is the single script that manages everything the Hug Activity does. Its funtion:
#1. Plays a voice message prompting to self-hug and displays appropriate texr
#2. Once the timer of 2 seconds is done, it starts playing soothing music & updates text message
#3. Now, it starts running a 15 second timer after which it prompts player to continue to next

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
	
	
#This function is called everframe by the game and all the timer mechanism lies here
func _process(delta):
	if isTimerActive: #Initially false and is set to true after 2 second timer by _on_ChangeInstructionsTimer_timeout function
		floatTime -= delta
		if currentNumberOfSeconds != ceil(floatTime): #Updating the counter after every second completion
			currentNumberOfSeconds = ceil(floatTime)
			timeLeftString.text = str(currentNumberOfSeconds)
		if currentNumberOfSeconds <= 0: #Checking if the timer is completed and changing the UI to go to next
			$TimerBG.hide()
			$Next.show() 
			emit_signal("activityOver") #Emit signal to stop 
			$StartingInstuction.hide()
			$Continue.show()
			$TilliHugging.stop()
			$TapToContinueSound.play()
			isTimerActive = false

# This function acts as a bridge for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://tilli.teqbahn.com/tilli-web/godot-redirect")'))
	get_tree().quit()


#Hiding the initial instructions after the child timer of 2 seconds runs out
func _on_ChangeInstructionsTimer_timeout():
	$StartingInstuction.text = "Hugs help reduce\nstress"
	isTimerActive = true #Start the main timer of 15 seconds 
	$TilliHugging.play("default") #Playing Tilli self hugging animation
	$HuggingBG.play() #Start playing soothing music

#Called on start of the game after a delay of 0.5 seconds set by the child timer of HugYourselfDialogue Node, it plays the dialogue
func _on_StartingTimer_timeout():
	$HugYourselfDialogue.play()
	

