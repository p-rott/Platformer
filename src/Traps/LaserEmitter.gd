tool
extends StaticBody2D

var l = preload("res://src/Traps/Laser.tscn")
var laser
onready var wallfinder = $WallFinder
export(int, 0, 360, 90) var rot
export var laserCooldown = 5.0
export var laserActive = 1.0
export var laserWarning = 1.0
export var firstDelay = 0.0

func _ready():
	snapToGrid()
	rotation_degrees = rot
	wallfinder.force_raycast_update()
	var wall = wallfinder.get_collision_point() 
	if wall != null:
		var dist = 0
		if rot == 90 or rot == 270:
			dist = abs(wall.y - position.y) - 5
		else:
			dist = abs(wall.x - position.x) - 5
		laser = l.instance()
		
		laser.setLaserLength(dist)
		laser.disableLaser()
		add_child(laser)
	setTimersAndStart()

#TODO is fukked
func snapToGrid():
	position = (position / 32).floor() * 32
	position += Vector2(20,20)

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
