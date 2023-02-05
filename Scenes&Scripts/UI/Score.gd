extends Node2D

func _process(delta):
	
	$AnimationPlayer.play("ScaleUp")
	
	yield($AnimationPlayer , "animation_finished")
	
	queue_free()
	
	pass
