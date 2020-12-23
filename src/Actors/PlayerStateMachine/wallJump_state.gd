extends JumpState
class_name WallJumpState

var frameCount = 0;

func _ready():
	animationPlayer.play("jumping")
	if(persistent_state.wall_detector_left.is_colliding()):
		persistent_state._velocity.x = 300
	else:
		persistent_state._velocity.x = -300
	persistent_state._velocity.y = -250

func move_left():
	frameCount = frameCount +1
	if(frameCount> persistent_state.blocked_wall_jump_frames):
		if sprite.flip_h:
			persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration*persistent_state.jumpAccelerationDecrease, -persistent_state.maxRunSpeed)
		else:
			sprite.flip_h = true
			persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo

func move_right():
	frameCount = frameCount +1
	if(frameCount>3):
		if not sprite.flip_h:
			persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration*persistent_state.jumpAccelerationDecrease, persistent_state.maxRunSpeed )
		else:
			sprite.flip_h = false
			persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo
