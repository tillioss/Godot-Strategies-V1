#This script is the main one that controls and directs the rest of the nodes accordingly. This does:
#1. Checks if the player is pressing the button or not and emits signals accordingly
#2. Keeps a track of the breathe cycle through timers
#3. Emits signals to update Rainbow UI and Text prompts

extends Node2D

export var numberOfBreathCycles = 1
export var BreatheTimer = 7
export var HoldTimer = 2

var timeHeld = 0
var numOfSeconds = 0
var isMouseOnLoveButton = false
var isBreatheInCompleted = false
var isHalfCycleEnd = false
var HeartIconSet = false
var numberOfCyclesDone = 0

var isCycleActive = false

signal loveButtonHeld
signal RequiredCyclesFinished
signal resetInstructions

#This function runs every frame
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT): #Checking if the player kept the mouse button pressed on not
		if isMouseOnLoveButton:
			if isBreatheInCompleted: #If the player is exhaling the timer is reduced back from post-breathe in state to 0
				#Multiplying by two to count at double speed. i.e one cycle takes 3.5 seconds if the timer says 7 seconds
				timeHeld -= delta*2 # Doing so for the ease of calculations it is easier to track 7 seconds that 3.5 seconds precisely
				if numOfSeconds != ceil(timeHeld):
					numOfSeconds = ceil(timeHeld)
			else: #If the player is inhaling, timer is counted till it reaches the required amount of seconds
				timeHeld += delta*2
				if numOfSeconds != floor(timeHeld):
					numOfSeconds = floor(timeHeld)
				
			#Checking if half of the cycle timer is reached and also if it has reached the mid-cycle and not the end
			if numOfSeconds == BreatheTimer and not isHalfCycleEnd:
				timeHeld = BreatheTimer #Round of the timeHeld float to restart the breathe out precisely
				isHalfCycleEnd = true #Setting BreatheIn is done
				isCycleActive = true #Setting a variable to track if a cycle has started. 
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, true) #Emitting signal to update text to Hold
				StopProcessForTimeMidCycle(HoldTimer) #Stopping the process for rquired time to execute "Hold Breath" in between the cycle
			else:
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, false) #Emitting a signal to set the rainbow and text perfectly when not in BreathHold state
				
			#timeHeld<0 only happens after the breathe out cycle is finished. The following if block resets everthing to restart cycle
			if timeHeld < 0:
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, true) #Setting Hold state to be true
				isBreatheInCompleted = false #Resetting values to restart cycle
				isHalfCycleEnd = false  
				timeHeld = 0
				numberOfCyclesDone = numberOfCyclesDone+1 #Updating the numberOfCycles done to keep a track of how many breath cycles player has done
				if numberOfCyclesDone >= numberOfBreathCycles: #Checking if required number of cycles done to let users go to next
					emit_signal("RequiredCyclesFinished") 
				StopProcessAtEndOfCycle(HoldTimer) #Hold the timer at breathe hold state before restarting the breathe cycle
				
			#Setting the heart Icon UI if the player is pressing it and it is not already set to pressed state
			if not HeartIconSet:
				$AnimatedSprite.play("pressed")
				HeartIconSet = true
			
#This function enables to stop the breathing process and calculations for a given amount of time
#Used for Hold after BreathIn state
func StopProcessForTimeMidCycle(time):
	set_process(false)
	yield(get_tree().create_timer(time), "timeout") #Waiting for the timer to end before enabling the process again
	#Checking isCycleActive because incase the player lets go of the heart button while in waiting state then we should actually restart the cycle
	#But after resetting all variables, as the yield might return back here after its time runs out and sets isBreatheInComplete= true which will disrupt the cycle.
	#As Letting go of heart icon resets all variables for eg isCycleActive= false, we're checking if the player hasn't let go of it to ensure we can continue with the cycle execution
	if isCycleActive:
		 isBreatheInCompleted = true #After Hold setting breatheIn completed state
	set_process(true) #Reenabling the process after hold

#This function enables to stop the breathing process and calculations for a given amount of time
#Used for Hold after BreathOut state and wait before restarting the cycle
func StopProcessAtEndOfCycle(time):
	set_process(false)
	yield(get_tree().create_timer(time), "timeout") #Waiting for the timer to end before enabling the process again
	set_process(true)  #Reenabling the process after hold

#The function is an inbuilt function that handles input			
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.is_pressed(): #Checking if the player released/let-go the heart button
			emit_signal("loveButtonHeld", 0, true, false) #Resetting the rainbow
			emit_signal("resetInstructions", "Press Heart") #Setting the text prompt to hold
			#Resetting all values
			timeHeld = 0
			isBreatheInCompleted = false
			isHalfCycleEnd = false
			isCycleActive = false
			$AnimatedSprite.play("not_pressed")
			HeartIconSet = false
	
#Signal that is received if the mouse is on the LoveButton so we can allow or not allow the breathing cycles
func _on_Area2D_mouse_entered():
	isMouseOnLoveButton = true

#Signal that is received if the mouse is NOT on the LoveButton so we can allow or not allow the breathing cycles
func _on_Area2D_mouse_exited():
	isMouseOnLoveButton = false
