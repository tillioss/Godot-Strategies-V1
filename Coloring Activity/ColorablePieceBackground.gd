extends Node2D

var isMouseOnShape = false
var colorToPaint : Color
var shapeToBePainted
# Called when the node enters the scene tree for the first time.
func _ready():
	colorToPaint = Color.white
	shapeToBePainted = $ShapeSprite

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if isMouseOnShape:
				print("Background Input Event registered")
				shapeToBePainted.modulate = colorToPaint
				get_tree().set_input_as_handled()

func _on_Area2D_mouse_entered():
	isMouseOnShape = true


func _on_Area2D_mouse_exited():
	isMouseOnShape = false
	
func _on_ColoringManager_ActiveColorChanged(activeColor, isNotWhite):
	colorToPaint = activeColor
