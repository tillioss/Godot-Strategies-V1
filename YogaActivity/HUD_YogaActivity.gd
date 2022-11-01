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

func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()

func _process(delta):
	if activeTimer:
		timerCount -= delta
		if numOfSeconds != ceil(timerCount):
			numOfSeconds = ceil(timerCount)
		TimerString.text = str(numOfSeconds)
		
		if not halfCycleReached and timerCount< (TotalNumberOfSeconds/2) :
			halfCycleReached = true
			_onTimerHalfComplete()
			#print("Half time completed")
			
		if timerCount < 0:
			activeTimer = false
			#print("Full time completed")
			$TimerBG.hide()
			$Next.show()
			emit_signal("activityOver")
			
	

func _onTimerHalfComplete():
	pass


func _on_HideInstructionsTimer_timeout():
	$StartingInstuction.text = "Do it with me!"
	activeTimer = true
	emit_signal("beginAnimation")
	#Start Animations
	

