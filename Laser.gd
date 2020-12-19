extends "res://src/Traps/Trap.gd"

func setLength(length):
	var factor = length / 32
	$Sprite.scale.x = factor
	$CollisionShape2D.scale.x = factor

func hide():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true

func show():
	$Sprite.visible = true
	$CollisionShape2D.disabled = false
