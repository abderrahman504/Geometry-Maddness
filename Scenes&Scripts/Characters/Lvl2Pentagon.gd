extends "res://Scenes&Scripts/Characters/Pentagon.gd"

var dashing : bool = false
var dashingTime : float
var dashingTimeCounter : float = 0
var beforeDashTime : float = 2
var beforeDashTimeCounter : float = 0


func handle_movement(delta):
	if not GlobalReferences.playerExists:
		return
	if not moving:
		look_at(player.position)
		return
	if beforeDashTimeCounter <= beforeDashTime:
		beforeDashTimeCounter += delta
		return
	
	
	if dashing == false:
		dash()
	
	if dashingTimeCounter >= dashingTime:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	dashingTimeCounter += delta
	
	if velocity == Vector2.ZERO:
		moving = false
		dashing = false
		beforeDashTimeCounter = 0
		dashingTimeCounter = 0
		return
	
	var tempVelocity : Vector2 = velocity
	velocity = move_and_slide(velocity)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			tempVelocity = handle_collision(get_slide_collision(i), tempVelocity)
	
	


func handle_collision(Collision : KinematicCollision2D, oldVelocity : Vector2):
	var momentumLossFactor : float = 0.25
	if Collision.collider is KinematicBody2D:
		var body : KinematicBody2D = Collision.collider
		body.velocity += -Collision.normal * momentumLossFactor * oldVelocity.length()
	
	
	var bounceVector : Vector2 = oldVelocity.bounce(Collision.normal).normalized()
	velocity = bounceVector * oldVelocity.length() * (1-momentumLossFactor)
	dashingTimeCounter = dashingTime
	return velocity


func dash():
	dashing = true
	dashingTime = (destination - position).length() / enemySpeed
	velocity = (destination - position).normalized() * enemySpeed








