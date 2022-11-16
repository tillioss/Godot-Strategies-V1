#This script is attached to the Background box
#It can be colored as well but not a compulsory objective to complete the activity
#This script recognizes input and colors accordingly using signals from the Parent of color palette

extends Node2D

var isMouseOnShape = false
var colorToPaint : Color
var shapeToBePainted

# Called when the node enters the scene tree for the first time.
func _ready():
	colorToPaint = Color.white #Initial default color
	shapeToBePainted = $ShapeSprite

#Inbuilt function that provides us with user choice and we can use that input
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed: #Left button pressed
			if isMouseOnShape:
				print("Background Input Event registered")
				shapeToBePainted.modulate = colorToPaint #Setting the color 
				get_tree().set_input_as_handled() #Cancelling the input mouse click after its purpose is done to avoid coloring overlappoing items

#Check if mouse pointer is on the node
func _on_Area2D_mouse_entered():
	isMouseOnShape = true

#Check if the mouse pointer exited this node
func _on_Area2D_mouse_exited():
	isMouseOnShape = false

#This function is connected to a signal in ColoringManager and gets called whenever a new color is picked
func _on_ColoringManager_ActiveColorChanged(activeColor, isNotWhite):
	colorToPaint = activeColor
	#isNotWhite can later be used like we've done in ColorablePieceShapes incase we decide we want the background to be colored for the activity to be said complete
