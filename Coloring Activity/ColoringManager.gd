#This script is attached to the parent node of all colors of the palette
#Must add any color node you want to function to be a child of this node
#This script does the following:
#1. Connects ever child's colorSelected signals to the NewColorSelected function
#2. Receives those signals and takes appropriate actions by emitting further signals to ColorableShapesParent
#3. Receives a signal from ColoableShapesParent that is called when all shapes are painted, then hides itself

extends Node2D
signal ActiveColorChanged

export onready var currentActiveColor = Color.white
var isARealColorAndNotWhite = false

onready var currentActiveColorNode

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_children(): 
		#Connecting the colorSelected signal of every child color to the NewColorSelected function
		_i.connect("colorSelected", self, "NewColorSelected")

#This function gets called when a new color is picked among the child colors
func NewColorSelected(colorSelected, NodeActive):
	if currentActiveColorNode != null:
		currentActiveColorNode.ActiveOrDeActivateColor(false) #Remove the tickmark from the previously active color and change the active indication color back to normal
	
	currentActiveColorNode = NodeActive #Getting a reference to the active node so that we can change the tick mark on it once a new color is selected
	currentActiveColor = colorSelected #Setting the activeColor
	if currentActiveColor != Color.white: #Sets the variable of Real Color to true on for non-white(default is white) colors
		isARealColorAndNotWhite = true
	emit_signal("ActiveColorChanged", currentActiveColor, isARealColorAndNotWhite) #Sending signal used by ColorableShapesParent to update the activeColor
	
#Returns current active color
func GetActiveColor():
	return currentActiveColor

#This function is connected to a a signal from ColoableShapesParent that is called when all shapes are painted, then hides itself
func _on_ColorableShapesParent_ActivityOverSendMessage():
	self.hide()
