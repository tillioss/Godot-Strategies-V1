extends Node2D

var AreAllShapesColored = false
signal ActivityOverSendMessage


func _ready():
	for _i in self.get_children():
		_i.connect("coloredThisShape", self, "OneMoreShapeColored")
		

func CheckIfAllShapesArePainted():
	var temp = true
	for _i in self.get_children():
		temp = temp and _i.GetIsColoredStatus()
	return temp


func OneMoreShapeColored():
	AreAllShapesColored = CheckIfAllShapesArePainted()
	print(AreAllShapesColored)
	if AreAllShapesColored:
		emit_signal("ActivityOverSendMessage")

func _on_ColoringManager_ActiveColorChanged(activeColor, isNotWhite):
	for _i in self.get_children():
		_i.ColorChanged(activeColor, isNotWhite)
