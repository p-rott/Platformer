extends State

class_name JumpState
var min_move_speed = 20

func _ready():
	animationPlayer.play("jumping")
	persistent_state._velocity.y = -250
	(persistent_state.jumpingAudio as AudioStreamPlayer).play()

func _physics_process(_delta):
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 0.01)
	if(persistent_state._velocity.y > 0 or persistent_state.is_on_ceiling()):
		persistent_state._velocity.y = 0
		change_state.call_func("falling")
		
	if persistent_state._velocity.x < 0:
		sprite.flip_h = true
	elif persistent_state._velocity.x > 0:
		sprite.flip_h = false
		

func move_left():
	if sprite.flip_h:
		persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration*persistent_state.jumpAccelerationDecrease, -persistent_state.maxRunSpeed)
	else:
		sprite.flip_h = true
		persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo


func move_right():
	if not sprite.flip_h:
		persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration*persistent_state.jumpAccelerationDecrease, persistent_state.maxRunSpeed )
	else:
		sprite.flip_h = false
		persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo

func horizontal_stop():
	persistent_state._velocity.x *= 1 - persistent_state.jumping_hDamping 

func jump():
	pass

func jump_released():
	persistent_state._velocity.y *= persistent_state.jump_cancel_factor

func sprint_pressed():
	if(persistent_state.wall_detector_left.is_colliding()  or persistent_state.wall_detector_right.is_colliding()):
		change_state.call_func("wallSlide")
