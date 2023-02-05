extends "res://Scenes&Scripts/Guns/BaseGun.gd"


func _init():
	gunType = GlobalReferences.GUNTYPES.SplitRifle

func _ready():
	shootingAngles = [0]
	splittingBullets = true
	bulletScaleFactor = 1.5
	bulletLifeTime = 3
	
