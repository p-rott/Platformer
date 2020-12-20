extends State

class_name WallSlideState

var min_move_speed = 0.005
var friction = 0.1

func _ready():
	sprite.flip_h = persistent_state.wall_detector_left.is_colliding()
	animationPlayer.play("falling")
	persistent_state._velocity.y = 0
	persistent_state._velocity.x = 0
	
	

func _physics_process(_delta):
	
	if(is_on_floor()):
		change_state.call_func("idle")
	persistent_state._velocity.y = min(persistent_state._velocity.y + 10, 50)
	if(not persistent_state.wall_detector_left.is_colliding() and sprite.flip_h):
		change_state.call_func("falling")
	elif(not persistent_state.wall_detector_right.is_colliding() and not sprite.flip_h):
		change_state.call_func("falling")
	pass

func move_left():
	
	pass

func move_right():
	pass

func jump():
	change_state.call_func("wallJump")
	
func sprint_pressed():
	pass
func sprint_released():
	print("released")
	change_state.call_func("falling")
