extends "res://Scenes&Scripts/Characters/BaseEnemy.gd"

var moving : bool = false
var destination : Vector2 = Vector2(-1, -1)
var slowingDown : bool = false


func _ready():
	gun = $HeavyCanon
	gun.user = self
	gunDropPath = GlobalReferences.GunDropPaths["heavy canon"];
	enemyType = GlobalReferences.COLOURS.Blue;
	
	find_destination()
	moving = true
	attackIntervalCounter = attackInterval


func handle_movement(delta):
	if not (GlobalReferences.playerExists):
		return
	if not moving:
		look_at(player.position)
		return
	var travelDirection : Vector2 = (destination - position).normalized() * enemySpeed
	look_at(position + travelDirection)
	if slowingDown:
		travelDirection = Vector2.ZERO
		if velocity == Vector2.ZERO:
			slowingDown = false
			moving = false
			attackIntervalCounter = attackInterval
	
	velocity = velocity.move_toward(travelDirection, acceleration * delta)
	if (destination - position).length() < enemySpeed * delta:
		slowingDown = true
	
	velocity = move_and_slide(velocity)
	


func handle_shooting(delta):
	if not GlobalReferences.playerExists:
		return
	
	if moving:
		return
	gun.shoot(player.position)
	attackIntervalCounter -= delta
	if attackIntervalCounter <= 0:
		attackIntervalCounter = attackInterval
		find_destination()
		moving = true
		



func _process(delta):
	handle_shooting(delta)


func _physics_process(delta):
	handle_movement(delta)



func find_destination():
	var playerPos : Vector2 = GlobalReferences.player.position
	var r = 200
	var x
	var xUpperBound
	var xLowerBound
	var y
	var yUpperBound
	var yLowerBound
	
	xLowerBound = playerPos.x - r
	xUpperBound = playerPos.x + r
	if xLowerBound < GlobalReferences.sceneRoot.TLCorner.x:
		xLowerBound = GlobalReferences.sceneRoot.TLCorner.x
	elif xUpperBound > GlobalReferences.sceneRoot.BRCorner.x:
		xUpperBound = GlobalReferences.sceneRoot.BRCorner.x
	
	x = GlobalReferences.randNoGen.randi_range(xLowerBound, xUpperBound)
	
	
	var R = sqrt(pow(r, 2) - pow(x-playerPos.x, 2))
	yUpperBound = playerPos.y + R
	yLowerBound = playerPos.y - R
	if yLowerBound < GlobalReferences.sceneRoot.TLCorner.y:
		yLowerBound = GlobalReferences.sceneRoot.TLCorner.y
	elif yUpperBound > GlobalReferences.sceneRoot.BRCorner.y:
		yUpperBound = GlobalReferences.sceneRoot.BRCorner.y
	
	y = GlobalReferences.randNoGen.randi_range(yLowerBound, yUpperBound)
	destination = Vector2(x,y)






