extends StaticBody2D

func setLength(length):
	$Sprite.scale.x = length / 32

func hide():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true

func show():
	$Sprite.visible = true
	$CollisionShape2D.disabled = false
