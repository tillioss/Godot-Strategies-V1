#This script is attached to the parent node that has all the color nodes as its children
#This script controls what colors to appear and what to hide based on the breathing state obtained from LoveButton script

extends Node2D

signal changeText
var halfCycleCompleted = false

#This function is connected to the LoveButton's Signal emitted when the lovebutton is held
func _on_LoveButton_loveButtonHeld(numberOfRings, isBreathing, isHold):
	#numberOfRings variable ranges from 0 to 6 indicating 7 colors of rainbow
	#The following for loop runs through all children and sets all the rings under this number visible and hides the rest
	for _i in self.get_children():
		if _i.get_index() < numberOfRings:
			_i.show()
		else:
			_i.hide()
	
	#Set the Instructions text based on the state sent by the LoveButton which is determined by its own timer
	if isHold:
		emit_signal("changeText", "Hold")
	else:
		if isBreathing:
			emit_signal("changeText", "Breathe In")
		else:
			emit_signal("changeText", "Breathe Out")
			
	
func _button_Release():
	emit_signal("changeText", "Press Heart")
