extends Label


var thisIsLevel2 : bool = false
var score = 0
var scoreToMoveToLevel2: int = 1500


func UpdateScore():
	score= score+100
	var scoretext= "Score: "+ String(score)
	text = scoretext
	if not thisIsLevel2:
		if score >= scoreToMoveToLevel2:
			movetolevel2()



func movetolevel2():
	var transitionAnimation = load(GlobalReferences.Level2Transition).instance()
	get_tree().paused = true
	transitionAnimation.position = GlobalReferences.sceneRoot.get_node("Camera2D").position
	GlobalReferences.sceneRoot.add_child(transitionAnimation)
