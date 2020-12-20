extends State

class_name IdleState

func _ready():
	animationPlayer.play("idle")
	persistent_state._velocity.x = 0

func _physics_process(_delta):
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 1)
	if(not is_on_floor()):
		change_state.call_func("falling")



func _flip_direction():
	sprite.flip_h = not sprite.flip_h

func move_left():
	if sprite.flip_h:
		change_state.call_func("run")
	else:
		_flip_direction()

func move_right():
	if not sprite.flip_h:
		change_state.call_func("run")
	else:
		_flip_direction()

func jump():
	change_state.call_func("jump")
	
func sprint_pressed():
	pass#change_state.call_func("sprint")
