tool
class_name LaserEmitter
extends StaticBody2D

var l = preload("res://src/Traps/Laser.tscn")
var laserBeam : Laser
var lastWall : Vector2
onready var wallfinder = $WallFinder
export(int, 0, 360, 90) var rot
export var scl = Vector2(1,1)
export var laserCooldown = 5.0
export var laserActive = 1.0
export var laserWarning = 1.0
export var firstDelay = 0.0
export var autostart = true
 
func _ready():
	rotation_degrees = rot
	scale = scl
	laserBeam = l.instance()
	add_child(laserBeam)
	updateLaserReach()
	if !get_parent().name == "LaserEmitterGroup":
		setTimersAndStart()

func _process(delta):
	updateLaserReach()

func updateLaserReach():
	wallfinder.force_raycast_update()
	var wall = to_local(wallfinder.get_collision_point()) 
	if wall != lastWall:
		lastWall = wall
		laserBeam.position = wallfinder.position
		laserBeam.setLaserLength(abs(wall.distance_to(wallfinder.position)))

func setTimersAndStart():
	if firstDelay == -1:
		return
	laserBeam.disableLaser()
	$CooldownTimer.stop()
	$CooldownTimer.set_one_shot(true)
	$CooldownTimer.set_wait_time(laserCooldown)
	$LaserActiveTimer.stop()
	$LaserActiveTimer.set_one_shot(true)
	$LaserActiveTimer.set_wait_time(laserActive)
	$LaserWarningTimer.stop()
	$LaserWarningTimer.set_one_shot(true)
	$LaserWarningTimer.set_wait_time(laserWarning)
	if firstDelay != 0.0:
		$FirstDelayTimer.set_wait_time(firstDelay)
		$FirstDelayTimer.start()
	else:
		$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	laserBeam.enableLaserWarning()
	$LaserWarningTimer.start()

func _on_FirstDelayTimer_timeout():
	$CooldownTimer.start()

func _on_LaserActiveTimer_timeout():
	$LaserActiveTimer.stop()
	laserBeam.disableLaser()
	$CooldownTimer.start()

func _on_LaserWarningTimer_timeout():
	$LaserWarningTimer.stop()
	laserBeam.enableLaser()
	$LaserActiveTimer.start()
