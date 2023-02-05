extends Control





func resume():
	GlobalReferences.sceneRoot.doNotPause = true
	hide()
	get_tree().paused = false


func exit():
	hide()
	get_tree().paused = false
	get_tree().change_scene(GlobalReferences.MainMenu)


func open_debug():
	pass
