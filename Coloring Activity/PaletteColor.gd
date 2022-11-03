extends Area2D

signal colorSelected

var isMouseOnColor = false
onready var BackgroundColor = $Background
onready var TickMark = $TickMark
onready var ColorOfThis = $ColorMain.modulate
onready var InitialBackgroundColor = $Background.modulate

var isActive = false
# Called when the node enters the scene tree for the first time.
#func _ready():
#	 get_parent().connect('ActiveColorChanged' , self, 'NewColorChangedPaletteSignal')

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if isMouseOnColor:
				#if isActive:
				#	BackgroundColor.modulate = InitialBackgroundColor
				#	TickMark.hide()
				#	isActive = false
				if not isActive:
					BackgroundColor.modulate = Color(1,1,1)
					TickMark.show()
					isActive = true
					emit_signal("colorSelected", ColorOfThis, get_node("."))

func _on_PaletteColor_mouse_entered():
	isMouseOnColor = true


func _on_PaletteColor_mouse_exited():
	isMouseOnColor = false
	
func ActiveOrDeActivateColor(shouldActivate):
	if shouldActivate:
		BackgroundColor.modulate = Color(1,1,1)
		TickMark.show()
		isActive = true
		emit_signal("colorSelected", ColorOfThis, get_node("."))
	else:
		BackgroundColor.modulate = InitialBackgroundColor
		TickMark.hide()
		isActive = false
		
	
func NewColorChangedPaletteSignal():
 emit_signal("colorSelected", ColorOfThis, get_node("."))
