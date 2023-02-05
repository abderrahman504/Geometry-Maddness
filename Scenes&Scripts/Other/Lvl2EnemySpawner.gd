extends Node2D

export(int) var timeBeforeLevelStart : float
export(int) var baseEnemySpawningTime : float
var adjustedEnemySpawningTime : float = baseEnemySpawningTime
var enemySpawningCounter : float = adjustedEnemySpawningTime
export(int) var maxNumberOfEnemies : int
export(float) var spawnDelayFactor : float #Positive values delay extend spawning time. negative values reduce it.
onready var pathFollow : PathFollow2D= $Path2D/PathFollow2D

func _process(delta):
	timeBeforeLevelStart -= delta
	if timeBeforeLevelStart > 0:
		return
	
	var numberOfEnemies : int = GlobalReferences.sceneRoot.enemiesInLevel.size()
	if numberOfEnemies >= maxNumberOfEnemies:
		return
	
	#Counting down until the next enemy spawn
	enemySpawningCounter -= delta
	if enemySpawningCounter <= 0:
		var enemy : KinematicBody2D = load(GlobalReferences.lvl2EnemyPaths[randi()%GlobalReferences.lvl2EnemyPaths.size()]).instance()
		pathFollow.offset = randi()
		enemy.position = pathFollow.global_position
		GlobalReferences.sceneRoot.get_node("Enemies").add_child(enemy)
		#Adjusting enemy spawn time depending on how many enemies in the level there are
		adjustedEnemySpawningTime = baseEnemySpawningTime*(1+ spawnDelayFactor*(float(numberOfEnemies)/float(maxNumberOfEnemies)))
		enemySpawningCounter = adjustedEnemySpawningTime



