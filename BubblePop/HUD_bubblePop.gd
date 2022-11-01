extends CanvasLayer

export var NumberOfBubbles = 20

signal activityOver
var bubbleCountString

# Called when the node enters the scene tree for the first time.
func _ready():
	bubbleCountString = $CounterBG/Score
	bubbleCountString.text = str(NumberOfBubbles)

func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()


func _on_BubbleSpawner_oneMoreBubblePopped():
	NumberOfBubbles = NumberOfBubbles-1
	bubbleCountString.text = str(NumberOfBubbles)
	if NumberOfBubbles == 0:
		$CounterBG.hide()
		$Next.show()
		emit_signal("activityOver")
		yield(get_tree().create_timer(3),"timeout")
		$Continue.show()
	


func _on_HideInstructionsTimer_timeout():
	$StartingInstuction.hide()

