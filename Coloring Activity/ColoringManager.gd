extends Node2D
signal ActiveColorChanged

export onready var currentActiveColor = Color.white
var isARealColorAndNotWhite = false

onready var currentActiveColorNode
# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_children():
		_i.connect("colorSelected", self, "NewColorSelected")
	#currentActiveColor.ActiveOrDeActivateColor(true)

func NewColorSelected(colorSelected, NodeActive):
	if currentActiveColorNode != null:
		currentActiveColorNode.ActiveOrDeActivateColor(false)
	
	currentActiveColorNode = NodeActive
	currentActiveColor = colorSelected
	if currentActiveColor != Color.white:
		isARealColorAndNotWhite = true
	#print("Color signal received")
	emit_signal("ActiveColorChanged", currentActiveColor, isARealColorAndNotWhite)
	
func GetActiveColor():
	return currentActiveColor


func _on_ColorableShapesParent_ActivityOverSendMessage():
	self.hide()
