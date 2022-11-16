#This script manages the UI elements of the Rainbow Breathing Activity. Like:
#1. Receive a text argument and change the breathing instruction text accordingly
#2. Show the next button once it receives a message that required number of breathing cycles are done

extends CanvasLayer

onready var TextMessage = $BreathingInstructions

#This function is connected to Rainbow Script or LoveButton Script and Changes the displayed breathing instruction based on received message.
func _on_changeText(message):
	TextMessage.text = message
	
#This function is connected to LoveButton and gets called when required number of cycles mentioned in LoveButton script are done
func _on_LoveButton_RequiredCyclesFinished():
	$Next.show()
	$Continue.show()

# Acts as bridge between godot game activity and the web app 
# When player presses on the next button this directs the player back to the webapp
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://tilli.teqbahn.com/tilli-web/godot-redirect")'))
	get_tree().quit()
