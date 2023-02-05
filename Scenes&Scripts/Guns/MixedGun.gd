extends "res://Scenes&Scripts/Guns/BaseGun.gd"


var parent1 : Node
var parent2 : Node



func _init():
	gunType = GlobalReferences.GUNTYPES.Mixed



func _ready():
	shootingAngles = [0]
	bulletDamage = (parent1.bulletDamage+parent2.bulletDamage)/2
	fireRate = (parent1.fireRate+parent2.fireRate)/2
	bulletLifeTime = parent1.bulletLifeTime*int(parent1.bulletLifeTime >= parent2.bulletLifeTime) + parent2.bulletLifeTime*int(parent1.bulletLifeTime < parent2.bulletLifeTime)
	bulletSpeedFactor = parent1.bulletSpeedFactor*int(parent1.bulletSpeedFactor <= parent2.bulletSpeedFactor) + parent2.bulletSpeedFactor*int(parent1.bulletSpeedFactor > parent2.bulletSpeedFactor)
	bulletScaleFactor = parent1.bulletScaleFactor*int(parent1.bulletScaleFactor >= parent2.bulletScaleFactor) + parent2.bulletScaleFactor*int(parent1.bulletScaleFactor < parent2.bulletScaleFactor)
	piercingBullets = parent1.piercingBullets or parent2.piercingBullets
	splittingBullets = parent1.splittingBullets or parent2.splittingBullets



func shoot(target):
	if cooldown > 0:
		return
	
	var gunAngle : float = (target - user.position).angle()
	for angle in shootingAngles:
		bullet = bulletScene.instance()
		var shootingVector : Vector2 = Vector2(cos(angle+gunAngle),sin(angle+gunAngle)) * user.bulletSpawnDistance
		bullet.position = user.position + shootingVector
		bullet.rotation = gunAngle + angle
		bullet.direction = shootingVector.normalized()
		#changing the bullet collision mask depending on who fired it
		if user == GlobalReferences.player:
			bullet.collision_mask = 16+2+32+64
			var gunColours : Vector2
			for record in GlobalReferences.colourToGunMap:
				if record["gun"] == parent1.gunType:
					gunColours.x = record["colour"];
				
				elif record["gun"] == parent2.gunType:
					gunColours.y = record["colour"];
			
			bullet.colour_bullet(gunColours.x, gunColours.y);
		else:
			bullet.collision_mask = 16+1
		
		bullet.splitting = splittingBullets
		bullet.piercing = piercingBullets
		bullet.scale *= bulletScaleFactor
		bullet.scaleFactor = bulletScaleFactor
		bullet.speed *= bulletSpeedFactor
		bullet.bulletDespawnTime = bulletLifeTime
		bullet.damage = bulletDamage
		bullet.mixed = true
		GlobalReferences.sceneRoot.add_child(bullet)
		
		
		#Handling ammo consumption and deleting the gun when it runs out of ammo
		var ammoBars = GlobalReferences.sceneRoot.get_node("UI/Control/AmmoBars")
		parent1.ammoCount -= parent1.ammoConsumption
		parent2.ammoCount -= parent2.ammoConsumption
		ammoBars.update_mixed_ammo_bar()
		
		if parent1.ammoCount <= 0:
			GlobalReferences.player.gun1 = parent2
			GlobalReferences.player.gun = parent2
			ammoBars.gun1 = parent2
			parent1.queue_free()
			parent1 = null
		
		if parent2.ammoCount <= 0:
			GlobalReferences.player.gun = parent1
			parent2.queue_free()
			parent2 = null
		
		if parent1 == null or parent2 == null:
			GlobalReferences.player.gun2 = null
			queue_free()
			if parent1 == null and parent2 == null:
				GlobalReferences.player.gun = GlobalReferences.playerPistol
		
		
		
		cooldown = 1/fireRate






