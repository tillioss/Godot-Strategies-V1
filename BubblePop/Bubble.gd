extends Area2D

var isMouseOnBubble = false
export var bubbleVelocity = 300
var isBubbleActive = true

signal bubblePopped

var popAnimationFinished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Bubble created")

func _process(delta):
	if isBubbleActive:
		var velocity = Vector2(0,0)
		velocity.y = bubbleVelocity
		position += velocity * delta

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if isMouseOnBubble and isBubbleActive:
				emit_signal("bubblePopped")
				$AnimatedSprite.play("pop")
				$PopSound.play()
				get_tree().set_input_as_handled()
				



func _on_Bubble_mouse_entered():
	isMouseOnBubble = true


func _on_Bubble_mouse_exited():
	isMouseOnBubble = false


func _on_AnimatedSprite_animation_finished():
	isBubbleActive = false
	#$AnimatedSprite.hide()
	#$CollisionShape2D.set_deferred("disabled", true)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
