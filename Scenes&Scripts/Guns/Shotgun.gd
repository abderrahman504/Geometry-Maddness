extends "res://Scenes&Scripts/Guns/BaseGun.gd"


var angleVariance1 : float = 5*(PI/180)
var angleVariance2 : float = 15*(PI/180)


func _init():
	gunType = GlobalReferences.GUNTYPES.Shotgun

func _ready():
	
	shootingAngles = [angleVariance1, -angleVariance1, angleVariance2, -angleVariance2]





