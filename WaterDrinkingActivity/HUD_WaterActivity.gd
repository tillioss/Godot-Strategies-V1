

extends CanvasLayer

export var TotalNumberOfSeconds = 20

signal activityOver
var timeLeftString

var currentNumberOfSeconds
var floatTime

var isTimerActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timeLeftString = $TimerBG/TimeLeft  #Having a reference to the counter variable
	timeLeftString.text = str(TotalNumberOfSeconds) 
	currentNumberOfSeconds = TotalNumberOfSeconds
	floatTime = TotalNumberOfSeconds
	
	
	
func _process(delta):
	if isTimerActive: #A variable to start drinking timer. To allow the user to fet
		floatTime -= delta
		if currentNumberOfSeconds != ceil(floatTime):
			currentNumberOfSeconds = ceil(floatTime)
			timeLeftString.text = str(currentNumberOfSeconds)
			if $WaterGlass.frame % 2 == 1:
				 $GulpSound.play()
			#print($WaterGlass.frame)
		if currentNumberOfSeconds <= 0:
			$TimerBG.hide()
			$Next_EndGame.show() 
			emit_signal("activityOver") #Emit signal to stop 
			$StartingInstuction.text = "Ah! Refreshing!"
			$Continue.show()
			$WaterGlass.stop()
			isTimerActive = false

# Supposedly developed for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp, for now it goes to Tilli website as a test
func _on_Next_button_down():
	isTimerActive = true
	$WaterGlass.play("WaterDrinking")
	$Continue.hide()
	$Next.hide()
	$StartingInstuction.text = "Drink the water and\nfeel it cool you down"
	$TimerBG.show()


func _on_StartingTimer_timeout():
	$HugYourselfDialogue.play()
	

func _on_Next_EndGame_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()
