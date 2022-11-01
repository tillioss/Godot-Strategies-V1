extends Node2D

export (PackedScene) var BubbleScene
export var NumberOfBubblesEachTurn = [2, 3, 4]
export var timeDeltaBetweenWaves = 1
export var minScale = 0.5
export var maxScale = 0.8

signal oneMoreBubblePopped

var areAllBubblesPopped = false

#var numberOfBubblesThisWave : int
var timer = 0

func _ready():
	randomize()

func _process(delta):
	if not areAllBubblesPopped:
		timer += delta
		if timer > timeDeltaBetweenWaves:
			timer = 0
			SpawnBubbleWave()

func SpawnBubbleWave():
	randomize()
	var numberOfBubblesThisWave = randi() % NumberOfBubblesEachTurn.size() + NumberOfBubblesEachTurn[0]
	var randomPositions = ChooseRandomPositionsBasedOnCount(numberOfBubblesThisWave)
	for i in numberOfBubblesThisWave:
		var bubble = BubbleScene.instance()
		get_parent().add_child(bubble)
		#add_child(bubble)
		#print(randomPositions[i].position)
		bubble.position = randomPositions[i].position + Vector2(rand_range(-50,50), rand_range(-50,50))
		var bubbleScale = rand_range(minScale, maxScale)
		bubble.scale = Vector2(bubbleScale, bubbleScale)
		bubble.connect("bubblePopped", self, "BubblePoppedReduceCounter")
	
func ChooseRandomPositionsBasedOnCount(count):
	var positionArray = []
	if count ==2:
		positionArray.append(self.get_child(randi()%3))
		positionArray.append(self.get_child(randi()%3 + 2))
	elif count==3:
		positionArray.append(self.get_child(randi()%2))
		positionArray.append(self.get_child(randi()%2 + 2))
		positionArray.append(self.get_child(randi()%2 + 4))
	elif count ==4:
		positionArray.append(self.get_child(0))
		positionArray.append(self.get_child(randi()%2 + 1))
		positionArray.append(self.get_child(randi()%2 + 3))
		positionArray.append(self.get_child(5))
	print(positionArray)
	return positionArray

func BubblePoppedReduceCounter():
	emit_signal("oneMoreBubblePopped")


func _on_HUD_bubblePop_activityOver():
	areAllBubblesPopped = true
