extends "res://src/Traps/Trap.gd"

var l = preload("res://src/Traps/Laser.tscn")
var laser
onready var wallfinder = $WallFinder

func _ready():
	wallfinder.force_raycast_update()
	var wall = wallfinder.get_collision_point() 
	if wall != null:
		var dist = abs(wall.x + 5 - position.x)
		#var dist = abs(wall.position.x + 2 * wall.cell_size.x - position.x)
		laser = l.instance()
		laser.setLength(dist)
		laser.hide()
		add_child(laser)
	$CooldownTimer.start()

func _on_LaserVisibleTimer_timeout():
	$LaserVisibleTimer.stop()
	print("_on_LaserVisibleTimer_timeout")
	laser.hide()
	$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	print("_on_CooldownTimer_timeout")
	$AnimationPlayer.play("Fire")
	laser.show()
	$LaserVisibleTimer.start()
