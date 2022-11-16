#This script is attached to the parent node of all colorable shapes
#Make sure that you drop any shape under this node for it to be part of the gamelogic integration
#This script does the following:
#1. At start connects the coloredThisShape signal in every child to OneMoreShapeColored function
#2. When a signal received that color is changed it loops through all child shapes and lets them know them the updated/active color
#3. Receives signals from child when they are colored
#4. Checks if all shapes are colored everytime a shape is colored
#5. Decides if the actiivity is over and notifies HUD and Palettes

extends Node2D

var AreAllShapesColored = false
signal ActivityOverSendMessage

# Called when the node enters the scene tree for the first time.
func _ready():
	#Connecting the child shape's coloredThisShape to this ParentNode's function OneMoreShapeColored
	for _i in self.get_children():
		_i.connect("coloredThisShape", self, "OneMoreShapeColored")
		
#Checks if all the child shapes are colored or not and returns a bool true or false
func CheckIfAllShapesArePainted():
	var temp = true
	for _i in self.get_children():
		temp = temp and _i.GetIsColoredStatus()
	return temp

#Is connected to the child and whenever a child is colored this function gets called.
#Checks if all the shapes are colored, if yes, emits a signal to show Continue UI and hide color palette
func OneMoreShapeColored():
	AreAllShapesColored = CheckIfAllShapesArePainted() #Gets true or false
	print(AreAllShapesColored)
	if AreAllShapesColored:
		emit_signal("ActivityOverSendMessage") #Emitting the signal

#This function is connected to the ColorManager's signal that emits evertime a new color is selected
func _on_ColoringManager_ActiveColorChanged(activeColor, isNotWhite):
	for _i in self.get_children():
		_i.ColorChanged(activeColor, isNotWhite) #Notifies all the child shapes that a new active color is selected and passes that color
