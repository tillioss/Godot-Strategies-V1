extends Node2D

signal changeText
var halfCycleCompleted = false

#func _ready():
	#_on_LoveButton_loveButtonHeld(0, true, true)

func _on_LoveButton_loveButtonHeld(numberOfRings, isBreathing, isHold):
	for _i in self.get_children():
		if _i.get_index() < numberOfRings:
			_i.show()
		else:
			_i.hide()
	
	if isHold:
		emit_signal("changeText", "Hold")
	else:
		if isBreathing:
			emit_signal("changeText", "Breathe In")
		else:
			emit_signal("changeText", "Breathe Out")
			
	
func _button_Release():
	emit_signal("changeText", "Press Heart")
