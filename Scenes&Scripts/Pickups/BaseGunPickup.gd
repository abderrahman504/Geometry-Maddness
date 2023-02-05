extends "res://Scenes&Scripts/Pickups/BasePickup.gd"


var gunType: int;


func run_pickup_effect():
	player.get_new_gun(gunType)

