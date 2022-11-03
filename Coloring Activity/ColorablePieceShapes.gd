extends Node2D

var isMouseOnShape = false
var colorToPaint : Color
var shapeToBePainted

var isShapePainted = false
var isARealColor = false

signal coloredThisShape
# Called when the node enters the scene tree for the first time.
func _ready():
	colorToPaint = Color.white
	shapeToBePainted = $ShapeSprite

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if isMouseOnShape:
				shapeToBePainted.modulate = colorToPaint
				if isARealColor:
					isShapePainted = true
				emit_signal("coloredThisShape")
				get_tree().set_input_as_handled()

func _on_Area2D_mouse_entered():
	isMouseOnShape = true


func _on_Area2D_mouse_exited():
	isMouseOnShape = false


func ColorChanged(activeColor, isNotWhite):
	colorToPaint = activeColor
	if isNotWhite:
		isARealColor = true
		
func GetIsColoredStatus():
	return isShapePainted
