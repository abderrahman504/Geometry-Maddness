extends Node2D

#Spawn variables.
var directionVector : Vector2;
var velocity : Vector2;
var speed : float = 350;
var deceleration : float = 500;


var player : KinematicBody2D
export (int) var pickUpRange : float = 75;
export (float) var lifeSpan : float = 8;
export (float) var fadeTime : float = 5;
export (int) var fadeSpeed : float = 250;
var increasingAlpha : bool = false;
var beingPickedUp : bool = false;



func _ready():
	GlobalReferences.tween.connect("tween_completed", self, "move_to_player_finished")
	player = GlobalReferences.player
	velocity = directionVector * speed


func _process(delta):
	if not GlobalReferences.playerExists:
		return
	position = position + velocity * delta
	velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	var distanceFromPlayer = (position - player.position).length()
	if distanceFromPlayer <= pickUpRange and not beingPickedUp:
		get_picked_up()
	
	lifeSpan -= delta
	if lifeSpan <= fadeTime:
		run_fade_effect(delta);
	
	if lifeSpan <= 0:
		queue_free()



func run_fade_effect(delta):
	if increasingAlpha:
		modulate.a8 += fadeSpeed * delta;
		if modulate.a8 >= 255:
			increasingAlpha = false;
	else:
		modulate.a8 -= fadeSpeed * delta;
		if modulate.a8 <= 0:
			increasingAlpha = true;
	





func get_picked_up():
	beingPickedUp = true
	var tween : Tween = GlobalReferences.tween
	tween.interpolate_property(self, "position", position, player.position, 0.1) # Tween nodes are useful for animating properties in code, here we animate the position of the pick up to the player position
	if not tween.is_active():
		tween.start()
	
	


func move_to_player_finished(object, key):
	if object != self:
		return
	
	run_pickup_effect()
	
	queue_free()


func run_pickup_effect(): #This funcion will be specified for each different type of pickup
	pass










