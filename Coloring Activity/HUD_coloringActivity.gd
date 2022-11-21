extends CanvasLayer

func _ready():
	yield(get_tree().create_timer(0.5),"timeout")
	$ExpressYourselvesSound.play()
	


# Acts as bridge between godot game activity and the web app 
# When player presses on the next button this directs the player back to the webapp
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://tilli.teqbahn.com/tilli-web/godot-redirect")'))
	get_tree().quit()

#This function is connected to signal from the parent of all colorable shapes and when all are colored, this prompts the player to continue
func _on_ColorableShapesParent_ActivityOverSendMessage():
	$StartingInstruction.hide()
	$TapToContinue.show() #Show continue text
	$Next.show() #Show continue button
	$TapToContinueSound.play()
	
