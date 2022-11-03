extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://www.tillikids.org/")'))
	get_tree().quit()


func _on_ColorableShapesParent_ActivityOverSendMessage():
	$StartingInstruction.hide()
	$TapToContinue.show()
	$Next.show()
	
