#This script is responsible for updating UI and some key decisions like:
#1. Receiving signals to update the Pop counter
#2. Signal the spawner to stop spawning once the counter requirement is reached
#3. Handle clicks on the next button to direct to the webapp

extends CanvasLayer

export var NumberOfBubbles = 20

signal activityOver
var bubbleCountString

# Called when the node enters the scene tree for the first time.
func _ready():
	bubbleCountString = $CounterBG/Score #Holding a reference to the score variable
	bubbleCountString.text = str(NumberOfBubbles) #Setting the value to our required bubble pop count
	yield(get_tree().create_timer(0.5),"timeout")
	$Pop20BubblesSound.play()

# The function acts as a bridge for integration between webapp and the game
# When player presses on the next button this directs the player back to the webapp
func _on_Next_button_down():
	OS.shell_open(JavaScript.eval('window.location.replace("https://tilli.teqbahn.com/tilli-web/godot-redirect")'))
	get_tree().quit()

#This is called by connecting to the BubbleSpawner's signal that tells us that a child bubble is popped
func _on_BubbleSpawner_oneMoreBubblePopped():
	#Updating the counter value and visual string text
	NumberOfBubbles = NumberOfBubbles-1 
	bubbleCountString.text = str(NumberOfBubbles)
	
	#Once the player has popped enough bubbles stop counting and emit a signal to stop spawning more bubbles
	if NumberOfBubbles == 0:
		$CounterBG.hide()
		$Next.show() 
		emit_signal("activityOver") #Emit signal to stop 
		yield(get_tree().create_timer(3),"timeout")
		$TapToContinueSound.play()
		$Continue.show() #Show text suggesting players to continue
	

#Hiding the initial instructions after the child timer runs out
func _on_HideInstructionsTimer_timeout():
	$StartingInstuction.hide()

