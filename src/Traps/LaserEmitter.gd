tool
extends StaticBody2D

var l = preload("res://src/Traps/Laser.tscn")
var laser
onready var wallfinder = $WallFinder
export(int, 0, 360, 90) var rot
export var scl = Vector2(1,1)
export var laserCooldown = 5.0
export var laserActive = 1.0
export var laserWarning = 1.0
export var firstDelay = 0.0

func _ready():
	rotation_degrees = rot
	scale = scl
	wallfinder.force_raycast_update()
	var wall = to_local(wallfinder.get_collision_point()) 
	if wall != null:
		laser = l.instance()
		#laser.setPositionAndTarget(wallfinder.position, wall)
		laser.position = wallfinder.position
		laser.setLaserLength(abs(wall.distance_to(wallfinder.position)))
		laser.disableLaser()
		add_child(laser)
	setTimersAndStart()

func setTimersAndStart():
	$CooldownTimer.set_wait_time(laserCooldown - 0.5)
	$LaserActiveTimer.set_wait_time(laserActive)
	$LaserWarningTimer.set_wait_time(laserWarning)
	if firstDelay != 0.0:
		$FirstDelayTimer.set_wait_time(firstDelay)
		$FirstDelayTimer.start()
	else:
		$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	laser.enableLaserWarning()
	$LaserWarningTimer.start()

func _on_FirstDelayTimer_timeout():
	$CooldownTimer.start()

func _on_LaserActiveTimer_timeout():
	$LaserActiveTimer.stop()
	laser.disableLaser()
	$CooldownTimer.start()

func _on_LaserWarningTimer_timeout():
	$LaserWarningTimer.stop()
	laser.enableLaser()
	$LaserActiveTimer.start()
