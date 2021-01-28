extends StaticBody2D
class_name Turret
export var rotate_speed = 90.0
export var turretShot : PackedScene
export var shotsPerSec : float = 10
export var coneDegree : float = 90
export var coneDirection : Vector2 = Vector2.LEFT
export var shootOnSight : bool = false

onready var TurretHead:=$TurretHead
onready var ray:=$TurretHead/RayCast2D
onready var Timer:= $Timer

var player = null
var canShoot
var startTime

var wasLoookingAt : Vector2

func _ready():
	Timer.set_wait_time(1.0/shotsPerSec)
	canShoot = true
	wasLoookingAt = coneDirection
	pass
func _process(delta):
	if(player != null):
		var normal = global_position.direction_to(player.global_position+Vector2(0,-16)).normalized()
		if(acos(normal.dot(coneDirection.normalized()))<deg2rad(coneDegree/2)): #Winkel berechnen, gucken ob der kleiner ist
			var angle = abs(wasLoookingAt.angle_to(normal))
			var t
			if(angle != 0):
				t = deg2rad(rotate_speed*delta)/angle		
				t = min (t, 1.0)
			else:
				t = 1
			wasLoookingAt = wasLoookingAt.slerp(normal, t)
			TurretHead.look_at(wasLoookingAt+global_position)
			shoot(wasLoookingAt)
		else:
			var angle = abs(wasLoookingAt.angle_to(coneDirection))
			var t
			if(angle != 0):
				t = deg2rad(rotate_speed*delta)/angle		
				t = min (t, 1.0)
			else:
				t = 1
			wasLoookingAt = wasLoookingAt.slerp(coneDirection, t)
			TurretHead.look_at(wasLoookingAt+global_position)

	else:
			var angle = abs(wasLoookingAt.angle_to(coneDirection))
			var t
			if(angle != 0):
				t = deg2rad(rotate_speed*delta)/angle		
				t = min (t, 1.0)
			else:
				t = 1
			wasLoookingAt = wasLoookingAt.slerp(coneDirection, t)
			TurretHead.look_at(wasLoookingAt+global_position)


func shoot(normal:Vector2)->void:
	if canShoot and ((ray.is_colliding() and ray.get_collider().is_in_group("Player")) or shootOnSight) :
		Timer.start()
		canShoot = false
		startTime = OS.get_system_time_msecs()
		
		var temp = turretShot.instance() as TurretShot
		add_child(temp)
		temp.global_position = TurretHead.global_position
		temp.rotation_degrees = TurretHead.rotation_degrees
		temp.setup(normal.rotated(deg2rad(-rotation_degrees)))
		
func bodyEntered(body:Node)->void:
	if(body.is_in_group("Player")):
		player = body

func bodyExited(body:Node)->void:
	if(body.is_in_group("Player")):
		player = null
func timeout()->void:
	canShoot = true
