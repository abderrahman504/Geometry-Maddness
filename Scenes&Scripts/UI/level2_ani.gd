extends Node2D


func _ready():
	$AnimationPlayer.play("Nuova Animazione")



func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false
	get_tree().change_scene("res://Scenes&Scripts/Other/Level2.tscn")
