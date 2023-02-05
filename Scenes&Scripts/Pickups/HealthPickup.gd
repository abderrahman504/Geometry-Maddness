extends "res://Scenes&Scripts/Pickups/BasePickup.gd"


export (int) var restoredHealth : int = 5;


func run_pickup_effect():
	player.recieve_damage(-1 * restoredHealth)
	if player.health > player.maxHealth:
		player.health = player.maxHealth
