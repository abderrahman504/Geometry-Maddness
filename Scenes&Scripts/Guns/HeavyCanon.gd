extends "res://Scenes&Scripts/Guns/BaseGun.gd"



func _init():
	gunType = GlobalReferences.GUNTYPES.HeavyCanon


func _ready():
	shootingAngles = [0]
	piercingBullets = true
	bulletScaleFactor = 3
	bulletSpeedFactor = 0.75



