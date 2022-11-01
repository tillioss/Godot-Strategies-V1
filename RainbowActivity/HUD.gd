extends CanvasLayer

onready var TextMessage = $BreathingInstructions

func _on_Rainbow_changeText(message):
	TextMessage.text = message
	
func _on_LoveButton_RequiredCyclesFinished():
	$Next.show()


func _on_LoveButton_resetInstructions():
	TextMessage.text = "Press Heart"

func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()
	#JavaScript.eval('window.location.replace("https://www.tillikids.org/')
