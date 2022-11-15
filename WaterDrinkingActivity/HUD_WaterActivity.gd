#This is the only script of the Water Activity and it handles everything like:
#1. It waits till the player fetches a water glass and clicks continue
#2. Starts the timer, while playing the water animation
#3. Periodically plays gulping sound every 2 seconds
#4. Once timer runs out, the glass will become empty, sound ends and prompts user to continue

extends CanvasLayer

export var TotalNumberOfSeconds = 20

var timeLeftString

var currentNumberOfSeconds
var floatTime

var isTimerActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timeLeftString = $TimerBG/TimeLeft  #Having a reference to the counter variable
	timeLeftString.text = str(TotalNumberOfSeconds) 
	currentNumberOfSeconds = TotalNumberOfSeconds #Integer tracker for seconds
	floatTime = TotalNumberOfSeconds #Float tracker form milli seconds based on delta time
	
	
	
func _process(delta):
	if isTimerActive: #A variable to check if player is ready to start drinking timer
		floatTime -= delta
		if currentNumberOfSeconds != ceil(floatTime): #Check if the timer has completed one more second
			currentNumberOfSeconds = ceil(floatTime)
			timeLeftString.text = str(currentNumberOfSeconds) #Update the COunter UI if one second has passed
			#This runs after a second is completed and plays gulping audio once every 2 seconds
			if $WaterGlass.frame % 2 == 1: #Current frame rate is 3 FPS, so frame number after every second is like 3,6,9, etc., Hence we can play sound effect at every odd framed second
				 $GulpSound.play() 
		if currentNumberOfSeconds <= 0: #Hides timer and prompts player to continue once the timer is up
			$TimerBG.hide() 
			$Next_EndGame.show() #Show the button the allows users to proceed when clicked
			$StartingInstuction.text = "Ah! Refreshing!"
			$Continue.show() #Show text message prompting player to click on the button
			$WaterGlass.stop()
			isTimerActive = false #Stop further counting as the activity is done

#When player is ready to drink water, i.e they've fetched water and presses continue
func _on_Next_button_down():
	isTimerActive = true #This enables the process function to start running timer and play animations
	$WaterGlass.play("WaterDrinking")
	$Continue.hide()
	$Next.hide() #Hide the next button and message as player has already clicked on it
	$StartingInstuction.text = "Drink the water and\nfeel it cool you down"
	$TimerBG.show() #Show the timer UI

# Supposedly developed for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp, for now it goes to Tilli website as a test
func _on_Next_EndGame_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()
