extends State

class_name DeathState

func _ready():
	persistent_state._velocity = Vector2.ZERO
	animationPlayer.play("die")

func _physics_process(_delta):
	pass

func move_left():
	pass
func move_left_released():
	pass

func move_right():
	pass
	
func move_right_released():
	pass
	
func horizontal_stop():
	pass

func jump():
	pass

func jump_released():
	pass

func sprint_pressed():
	pass

func sprint_released():
	pass

func is_on_floor():
	pass

func die():
	pass
