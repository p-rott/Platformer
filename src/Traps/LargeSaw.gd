extends Trap
class_name SparkTrap

export var alwaysDeadly = false
onready var timer = $DesyncTimer
onready var animation = $AnimationPlayer

func _ready():
	timer.set_wait_time(rand_range(0.1, 0.7))
	timer.one_shot = true
	timer.start()
	if alwaysDeadly:
		var alwaysOnCollision = $CollisionShape2D.duplicate()
		alwaysOnCollision.disabled = false
		add_child(alwaysOnCollision)

func _on_DesyncTimer_timeout():
	animation.play_backwards("Flicker") if randf() > 0.5 else animation.play("Flicker")
