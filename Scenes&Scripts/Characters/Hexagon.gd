extends "res://Scenes&Scripts/Characters/BaseEnemy.gd"


var clockwiseMove : bool = false
var maxRange : float = 250



func _ready():
	gun = $SplitRifle
	gun.user = self
	gunDropPath = GlobalReferences.GunDropPaths["split rifle"];
	enemyType = GlobalReferences.COLOURS.Yellow;



func _process(delta):
	handle_shooting(delta)


func _physics_process(delta):
	handle_movement(delta)


func handle_movement(delta):
	if not GlobalReferences.playerExists:
		return
	look_at(player.position)
	
	
	var moveVector = (player.position - position).tangent().normalized() *pow(-1, int(clockwiseMove)) + (player.position - position).normalized()*0.5
	var dFromPlayer : float = (position - player.position).length()
	if dFromPlayer >= maxRange:
		moveVector += (player.position - position).normalized()
	
	velocity = velocity.move_toward(moveVector*enemySpeed, acceleration * delta)
	velocity = move_and_slide(velocity)



func handle_shooting(delta):
	if not GlobalReferences.playerExists:
		return
	
	if breakTimeCounter <= 0:
		gun.shoot(player.position)
		if attackIntervalCounter <= 0:
			breakTimeCounter = breakTime
			attackIntervalCounter = attackInterval
			clockwiseMove = not clockwiseMove
		
		attackIntervalCounter -= delta
	
	breakTimeCounter -=delta


