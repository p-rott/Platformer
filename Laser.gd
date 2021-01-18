extends "res://src/Traps/Trap.gd"

func setLaserLength(length):
	var factor = (length + 22) / 32
	$Sprite.scale.x = factor
	$CollisionShape2D.scale.x = factor

func setPositionAndTarget(pos, target):
	var dist = pos.distance_to(target)
	position = pos + (pos + target) / 2
	var factor = abs(dist) / 32
	scale.x = factor

func enableLaserWarning():
	$Sprite.visible = true
	$Sprite.modulate = Color(1,1,1,0.5)

func enableLaser():
	$Sprite.visible = true
	$Sprite.modulate = Color(1,1,1,1)
	$CollisionShape2D.disabled = false

func disableLaser():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
