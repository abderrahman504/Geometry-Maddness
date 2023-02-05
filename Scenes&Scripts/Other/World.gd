extends Node2D


var enemiesInLevel : Array

export var TLCorner : Vector2
export var BRCorner : Vector2

func _init():
	GlobalReferences.randNoGen = RandomNumberGenerator.new()
	GlobalReferences.sceneRoot = self


func _ready():
	
	randomize()
	$BackgroundMusic.play()


var doNotPause : bool = false

func _unhandled_input(event):
	if event.is_action_pressed("Escape"):
		if doNotPause:
			doNotPause = false
			return
		
		get_tree().paused = true
		$UI/PauseMenu.show()











