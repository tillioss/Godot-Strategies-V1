#This script deals with all the Bubble behaviour
#that includes but not limited to
#1. Updating the bubbles position every frame based on its speed
#2. Checking if player is clicking on the bubble
#3. Sending signal once it is popped and 
#4. Playing appropriate sound effect and animations
#5. Self-destroying if it isnt popped and gone out of visible screen

extends Area2D

var isMouseOnBubble = false
export var bubbleVelocity = 300
var isBubbleActive = true
signal bubblePopped
var popAnimationFinished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Bubble created")
	

# Called every frame
func _process(delta):
	if isBubbleActive:
		var velocity = Vector2(0,0)
		velocity.y = bubbleVelocity  #Setting a value for how much distance a bubble should move every frame
		position += velocity * delta #Multiplying the speed with delta to make the game frame independent and then added to position to create movement

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed: #Checking if the left mouse button is clicked
			if isMouseOnBubble and isBubbleActive: #Checkin if the mouse is over this bubble when clicked and isActive
				emit_signal("bubblePopped") #Emitting signal that this is popped and this will be received by the parent which is BubbleSpawner
				$AnimatedSprite.play("pop") #Animations
				$PopSound.play() #SFX
				get_tree().set_input_as_handled() #Making sure that the bubble below this doesn't pop. So cancelling the input once we're done
				


#Setting isMouseOnBubble to check if the mouse is over this bubble
func _on_Bubble_mouse_entered():
	isMouseOnBubble = true


func _on_Bubble_mouse_exited():
	isMouseOnBubble = false

#Waiting for the pop animation to be done and when done we destroy the bubble
func _on_AnimatedSprite_animation_finished():
	isBubbleActive = false
	queue_free() #Destroying/Freeing the bubble from memory

#Checking if the bubble left/went out of screen and if so destory it
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #Destroying/Freeing the bubble from memory
