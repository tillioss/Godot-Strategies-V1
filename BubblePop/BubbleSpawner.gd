extends Node2D

export (PackedScene) var BubbleScene
export var NumberOfBubblesEachTurn = [2, 3, 4]
export var timeDeltaBetweenWaves = 1
export var minScale = 0.5
export var maxScale = 0.8

signal oneMoreBubblePopped

var areAllBubblesPopped = false
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #Helps get different number of bubbles and positions every run

# Called every frame till the node becomes inactive or destroyed
func _process(delta):
	if not areAllBubblesPopped: #Checks if the player has already popped required number of bubbles
		timer += delta 
		if timer > timeDeltaBetweenWaves: #This is a timer based wave like spawning
			timer = 0 #Reset timer to begin counting for next wave
			SpawnBubbleWave() #Spawns random number of bubbles on timer completion

#This function helps
func SpawnBubbleWave():
	#We choose a random number of bubbles from the list possible values which we currently gave as 2 or 3 or 4
	var numberOfBubblesThisWave = randi() % NumberOfBubblesEachTurn.size() + NumberOfBubblesEachTurn[0]
	var randomPositions = ChooseRandomPositionsBasedOnCount(numberOfBubblesThisWave) # Based on how many bubbles we want, we call a function that gives that many spawn points
	for i in numberOfBubblesThisWave:
		var bubble = BubbleScene.instance() #Creating a bubble instance
		get_parent().add_child(bubble) #Making the created a child of the BubbleSpawnerNode so we can easily connect signals
		bubble.position = randomPositions[i].position + Vector2(rand_range(-50,50), rand_range(-50,50)) # Getting positions of the spawn points and using their positions and random values to get more variety
		var bubbleScale = rand_range(minScale, maxScale)
		bubble.scale = Vector2(bubbleScale, bubbleScale) #Randomizing the size of the bubble spawned
		bubble.connect("bubblePopped", self, "BubblePoppedReduceCounter") #Connecting the bubblePopped signal of the bubble created so we can know when its popper. Thereby, helps us update the counter

#Function used to get a set of points from a predefined spawn point list of 6
func ChooseRandomPositionsBasedOnCount(count):
	var positionArray = []
	if count ==2:
		positionArray.append(self.get_child(randi()%3)) #Choose one spawn point from first 3
		positionArray.append(self.get_child(randi()%3 + 3))  #Choose one spawn point from last 3
	elif count==3:
		positionArray.append(self.get_child(randi()%2))  #Choose one spawn point from first 2
		positionArray.append(self.get_child(randi()%2 + 2))
		positionArray.append(self.get_child(randi()%2 + 4))
	elif count ==4:
		positionArray.append(self.get_child(0))  #Choose 1st, one from 2 and 3, one from 4 and 5 and 6th
		positionArray.append(self.get_child(randi()%2 + 1))
		positionArray.append(self.get_child(randi()%2 + 3))
		positionArray.append(self.get_child(5))
	print(positionArray)
	return positionArray #Return the list with required number of spawn points

#This function is called whenever a bubble which is a child of this is popped
func BubblePoppedReduceCounter():
	emit_signal("oneMoreBubblePopped")  #Emittin a signal so that other nodes like HUD can connect and update counter details

#This function is linked to HUD and when the required number of bubbles are popped, it stops the spawning of bubbles by setting the decisive bool used in _process to true
func _on_HUD_bubblePop_activityOver():
	areAllBubblesPopped = true
