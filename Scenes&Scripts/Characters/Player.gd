extends KinematicBody2D

export(float) var maxSpeed : float
export(float) var acceleration : float
export(float) var deceleration : float
export(int) var maxHealth : int
var health : int
var myHealthBar : TextureProgress
var gun : Node
var gun1 : Node
var gun2 : Node
var velocity : Vector2
var inputVector : Vector2
var bulletSpawnDistance : float = 25 #How far the bullet will spawn away from the player

var tween : Tween

var root : Node2D
var ammoBars : Container


func _init():
	GlobalReferences.player = self


func _ready():
	tween = GlobalReferences.tween
	root = GlobalReferences.sceneRoot
	ammoBars = root.get_node("UI/Control/AmmoBars")
	GlobalReferences.playerExists = true
	#Creating the player health bar
	health = maxHealth
	var healthbarNode : Node2D
	healthbarNode = load(GlobalReferences.healthbarPath).instance()
	healthbarNode.myOwner = self
	myHealthBar = healthbarNode.get_node("TextureProgress")
	healthbarNode.position = position
	myHealthBar.max_value = maxHealth
	myHealthBar.value = health
	add_child(healthbarNode)
	#spawning the pistol weapon for the player
	var pistol : Node = load(GlobalReferences.GunPaths["pistol"]).instance()
	GlobalReferences.playerPistol = pistol
	pistol.user = self
	gun = pistol
	add_child(pistol)



func _process(_delta):
	#If the lmb is pressed, the gun will try to shoot - if the gun cool down is 0 then it will shoot
	if Input.is_action_pressed("LMB"):
		gun.shoot(get_global_mouse_position())
		



func _physics_process(delta):
	#This block of code is for Movement and Rotation
	look_at(get_global_mouse_position())
	inputVector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputVector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	inputVector = inputVector.normalized()
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector*maxSpeed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	velocity = move_and_slide(velocity)
	


func recieve_damage(damage):
	health -= damage
	tween.interpolate_property(myHealthBar, "value", myHealthBar.value, health, 0.2)
	if not tween.is_active():
		tween.start()
	if health <= 0:
		GlobalReferences.sceneRoot.get_node("DeathSound").play()
		queue_free()
		GlobalReferences.playerExists = false
		var deathMenu = load(GlobalReferences.DeathMenu).instance()
		GlobalReferences.sceneRoot.get_node("UI").add_child(deathMenu)




func get_new_gun(gunPickupType : int):
	
	if gun.gunType == gunPickupType:
		gun.ammoCount = gun.maxAmmo
		ammoBars.update_ammo_bar()
		return
	
	if gun.gunType == GlobalReferences.GUNTYPES.Mixed:
		
		if gunPickupType == gun1.gunType:
			gun1.ammoCount = gun1.maxAmmo
			ammoBars.update_mixed_ammo_bar()
			return
		
		elif gunPickupType == gun2.gunType:
			gun2.ammoCount = gun2.maxAmmo
			ammoBars.update_mixed_ammo_bar()
			return
		
		gun2.queue_free() #Deletes the older of the two guns
		gun.queue_free() #Delete the old mixed gun
	
	var newGun : Node
	if gunPickupType == GlobalReferences.GUNTYPES.Machinegun:
		newGun = load(GlobalReferences.GunPaths["machinegun"]).instance()
	elif gunPickupType == GlobalReferences.GUNTYPES.Shotgun:
		newGun = load(GlobalReferences.GunPaths["shotgun"]).instance()
	elif gunPickupType == GlobalReferences.GUNTYPES.SplitRifle:
		newGun = load(GlobalReferences.GunPaths["split rifle"]).instance()
	elif gunPickupType == GlobalReferences.GUNTYPES.HeavyCanon:
		newGun = load(GlobalReferences.GunPaths["heavy canon"]).instance()
	
	newGun.user = self
	
	
	if gun == GlobalReferences.playerPistol:
		gun1 = newGun
		gun = newGun
		ammoBars.gun1 = gun1
		ammoBars.update_ammo_bar()
		add_child(newGun)
		return
	
	
	gun2 = gun1
	gun1 = newGun
	add_child(newGun)
	var mixedGun = load(GlobalReferences.GunPaths["mixed gun"]).instance()
	mixedGun.user = self
	mixedGun.parent1 = gun1
	mixedGun.parent2 = gun2
	gun = mixedGun
	ammoBars.gun1 = gun1
	ammoBars.gun2 = gun2
	ammoBars.update_mixed_ammo_bar()
	add_child(gun)
	




