class_name FallingPlatform
extends StaticBody2D

var hasFallen = false

func _ready():
	reset()

func reset():
	$CollisionShape2D.disabled = false
	hasFallen = false
	$AnimationPlayer.stop()
	$Sprite.set_modulate(Color(1,1,1,1))

func touched():
	if !hasFallen:
		hasFallen = true
		$AnimationPlayer.play("fall")

func fall():
	$CollisionShape2D.disabled = true
