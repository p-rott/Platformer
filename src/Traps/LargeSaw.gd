extends Trap
class_name SparkTrap

export var alwaysDeadly = false

func _ready():
	if alwaysDeadly:
		var alwaysOnCollision = $CollisionShape2D.duplicate()
		alwaysOnCollision.disabled = false
		add_child(alwaysOnCollision)
	$AnimationPlayer.play("Flicker")
