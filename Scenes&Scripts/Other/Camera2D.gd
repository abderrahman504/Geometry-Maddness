extends Camera2D

var pointBetweenPlayerAndMouse : Vector2 #A vector that is the point between the player and the mouse. Not exactly in the middle of them however.






func _process(_delta):
	if GlobalReferences.playerExists:
		pointBetweenPlayerAndMouse = GlobalReferences.player.position + (get_global_mouse_position() - GlobalReferences.player.position) * 0.3
		position = pointBetweenPlayerAndMouse
