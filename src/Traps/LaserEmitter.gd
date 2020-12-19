tool
extends StaticBody2D

var l = preload("res://src/Traps/Laser.tscn")
var laser
onready var wallfinder = $WallFinder
export(int, 0, 360, 90) var rot
export(bool) var flip = false
export var laserCooldown = 5.0
export var laserActive = 1.0
export var firstDelay = 0.0

func _ready():
	rotation_degrees = rot
	$Sprite.flip_v = flip
	wallfinder.force_raycast_update()
	var wall = wallfinder.get_collision_point() 
	if wall != null:
		var dist = 0
		if rot == 90 or rot == 270:
			dist = abs(wall.y - position.y) - 5
		else:
			dist = abs(wall.x - position.x) - 5
		laser = l.instance()
		laser.setLength(dist)
		laser.hide()
		add_child(laser)
	setTimersAndStart()

func setTimersAndStart():
	$CooldownTimer.set_wait_time(laserCooldown - 0.5)
	$LaserVisibleTimer.set_wait_time(laserActive)
	if firstDelay != 0.0:
		$FirstDelayTimer.set_wait_time(firstDelay)
		$FirstDelayTimer.start()
	else:
		$CooldownTimer.start()

func _on_LaserVisibleTimer_timeout():
	$LaserVisibleTimer.stop()
	laser.hide()
	$CooldownTimer.start()

func enableLaser():
	laser.show()
	$LaserVisibleTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	$AnimationPlayer.play("Fire")

func _on_FirstDelayTimer_timeout():
	$CooldownTimer.start()
