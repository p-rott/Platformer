class_name FallingPlatform
extends StaticBody2D

var hasFallen = false

#fall time is currently set via animation, this is bad
func _ready():
	reset()

func reset():
	hasFallen = false
	$AnimationPlayer.stop()
	$Sprite.set_modulate(Color(1,1,1,1))
	$CollisionShape2D.disabled = false

func touched():
	print("plaform is touched")
	if !hasFallen:
		hasFallen = true
		$AnimationPlayer.play("fall")

func fall():
	print("plattform fallen")
	$CollisionShape2D.disabled = true
