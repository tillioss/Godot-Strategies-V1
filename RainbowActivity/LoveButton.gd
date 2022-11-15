#This script is the main one that controls and directs the rest of the nodes accordingly. This does:
#


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
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if isMouseOnLoveButton:
			if isBreatheInCompleted: #If the player is exhaling the timer is reduced back from post-breathe in state to 0
				timeHeld -= delta*2 # Multiplying by two to count at double speed. i.e one cycle takes 3.5 seconds if the timer says 7 seconds
				if numOfSeconds != ceil(timeHeld):
					numOfSeconds = ceil(timeHeld)
			else: #If the player is inhaling, timer is counted till it reaches the required amount of seconds
				timeHeld += delta*2
				if numOfSeconds != floor(timeHeld):
					numOfSeconds = floor(timeHeld)
				
			
			if numOfSeconds == BreatheTimer and not isHalfCycleEnd:
				timeHeld = BreatheTimer
				isHalfCycleEnd = true
				isCycleActive = true
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, true)
				
				numOfSeconds = BreatheTimer
				StopProcessForTimeMidCycle(HoldTimer)
			else:
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, false)
				
				
			if timeHeld < 0:
				emit_signal("loveButtonHeld", numOfSeconds, !isBreatheInCompleted, true)
				isBreatheInCompleted = false
				isHalfCycleEnd = false
				timeHeld = 0
				numberOfCyclesDone = numberOfCyclesDone+1
				if numberOfCyclesDone >= numberOfBreathCycles:
					emit_signal("RequiredCyclesFinished")
				StopProcessAtEndOfCycle(HoldTimer)
				
			if not HeartIconSet:
				$AnimatedSprite.play("pressed")
				HeartIconSet = true
			
	
func StopProcessForTimeMidCycle(time):
	set_process(false)
	yield(get_tree().create_timer(time), "timeout")
	if isCycleActive:
		 isBreatheInCompleted = true
	set_process(true)
		
func StopProcessAtEndOfCycle(time):
	set_process(false)
	yield(get_tree().create_timer(time), "timeout")
	if isCycleActive:
		isBreatheInCompleted = false
		isHalfCycleEnd = false
		timeHeld = 0
	set_process(true)
			
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.is_pressed():
			emit_signal("loveButtonHeld", 0, true, false)
			emit_signal("resetInstructions", "Press Heart")
			timeHeld = 0
			isBreatheInCompleted = false
			isHalfCycleEnd = false
			isCycleActive = false
			$AnimatedSprite.play("not_pressed")
			HeartIconSet = false
	

func _on_Area2D_mouse_entered():
	isMouseOnLoveButton = true


func _on_Area2D_mouse_exited():
	isMouseOnLoveButton = false
