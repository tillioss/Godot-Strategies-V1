#This script is attached to every single color of the palette
#NOTE: For an new color to function as expected, make sure to make this node a child of the ColoringManager Node
#This script does the following:
#1. Emits signal to parent if the color is clicked and selected
#2. Changes back the old color to inactive upon function getting called by parent i.e ColoringManager

extends Area2D

signal colorSelected

var isMouseOnColor = false
onready var BackgroundColor = $Background #onready is similiar to assigning this value in _ready function
onready var TickMark = $TickMark
onready var ColorOfThis = $ColorMain.modulate
onready var InitialBackgroundColor = $Background.modulate #Storing the initial color of the background circle around the color

var isActive = false

#This is an inbuilt function that lets us get the user input
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if isMouseOnColor and not isActive: #If the mouse pointer is on color and the color is not currently active
					BackgroundColor.modulate = Color(1,1,1) #Set the background color i.e the circle around the color to white to indicate that this is an active color
					TickMark.show() #Show visual feedback of the color active status
					isActive = true
					emit_signal("colorSelected", ColorOfThis, get_node(".")) #Send a signal, usually the parent ColorManager receives it and further propogates it

#Gets called when the mouse is on the color circle
func _on_PaletteColor_mouse_entered():
	isMouseOnColor = true

#Gets called when the mouse exited the color circle
func _on_PaletteColor_mouse_exited():
	isMouseOnColor = false

#This funtion is called by the parent node which is ColoringManager
func ActiveOrDeActivateColor(shouldActivate):
	if shouldActivate: #Setting tick mark active and bg color to white  to show thw players the active color
		BackgroundColor.modulate = Color(1,1,1)
		TickMark.show()
		isActive = true
		emit_signal("colorSelected", ColorOfThis, get_node("."))
	else: #Change back to inactive state and hide the tick mark and change back the bg circle color
		BackgroundColor.modulate = InitialBackgroundColor
		TickMark.hide()
		isActive = false
		
	
func NewColorChangedPaletteSignal():
 emit_signal("colorSelected", ColorOfThis, get_node("."))
