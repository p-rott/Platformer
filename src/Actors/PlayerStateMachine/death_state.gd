extends State

class_name DeathState

func _ready():
	persistent_state._velocity.y = -400
	animationPlayer.play("die")

func _physics_process(_delta):
	pass

func _flip_direction():
	pass

func move_left():
	pass

func move_right():
	pass

func jump():
	pass

func sprint_pressed():
	pass
func die():
	pass
