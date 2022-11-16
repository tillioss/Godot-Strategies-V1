#This script should be attached to every shape node that can be colored
#MUST: This node should be a child of the ColorableShapesParent to work as intended
#This script does the following:
#1. Checks input if the player clicked on this shape
#2. Colors the shape based on the active color in the palette.
#3. If the color is non-white, it marks the isShapePainted to true so that when all shapes are painted game can progress
#4. Else if it the default white, it colors it but ignores changing the status
#5. For non-white color painted, Emits a signal notifying to the parent that this is colored. The parent checks if everything is painted or not

extends Node2D

var isMouseOnShape = false
var colorToPaint : Color
var shapeToBePainted

var isShapePainted = false
var isARealColor = false

signal coloredThisShape

# Called when the node enters the scene tree for the first time.
func _ready():
	colorToPaint = Color.white #Default color 
	shapeToBePainted = $ShapeSprite 

#Inbuilt function that provides us with user choice and we can use that input
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed: #Left mouse button Clicked
			if isMouseOnShape: #To see if Mouse pointer is on this shape when clicked
				shapeToBePainted.modulate = colorToPaint #Change Color
				if isARealColor:  #As we do not consider default white which isnt in the palette, coloring with white doesn't change the status of this shape's colored or not to true
					isShapePainted = true #When colored with non-white, changes the status to true
				emit_signal("coloredThisShape") #Everytime this signal is emitted the ColorableShapesParent Checks if all the shapes are painted or not to finish the activity
				get_tree().set_input_as_handled() #Cancelling the current input so as to avoid coloring the same on overlapped nodes

#Check if mouse pointer is on the node, used to check if the click is on the node or not
func _on_Area2D_mouse_entered():
	isMouseOnShape = true

#Check if the mouse pointer exited this node
func _on_Area2D_mouse_exited():
	isMouseOnShape = false

#This function is called by the ColorableShapesParent which is a parent node to this
#This is used to set the active color color plaer selected in the palette and use it to color this node
func ColorChanged(activeColor, isNotWhite):
	colorToPaint = activeColor
	if isNotWhite: #This is used to keep a track of the status of the node - Colored or not
		isARealColor = true #To know if it's default color(white) or some color other than white

#Function that returns the colored status of this shape. Used to check the activity completion
func GetIsColoredStatus():
	return isShapePainted
