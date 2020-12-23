extends State

class_name FallingState
var min_move_speed = 20

func _ready():
	animationPlayer.play("falling")
	persistent_state._velocity.y = 0
	

func _physics_process(_delta):
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 0.01)
	if is_on_floor():
		
		persistent_state.puff.emitting = true
		persistent_state.puff.restart()
		if abs(persistent_state._velocity.x) < min_move_speed:
				change_state.call_func("idle")
		else:
			change_state.call_func("run")
	else: 
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
	persistent_state._velocity.x *= 1 - persistent_state.falling_hDamping
func jump():
	persistent_state.jump_buffer = persistent_state.jump_buffer_time_s
	pass
	
func sprint_pressed():
	if(persistent_state.wall_detector_left.is_colliding() or persistent_state.wall_detector_right.is_colliding()):
		change_state.call_func("wallSlide")
