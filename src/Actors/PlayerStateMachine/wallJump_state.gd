extends JumpState
class_name WallJumpState

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var frameCount = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("jumping")
	if(persistent_state.wall_detector_left.is_colliding()):
		persistent_state._velocity.x = 300
	else:
		persistent_state._velocity.x = -300
	persistent_state._velocity.y = -250

func move_left():
	frameCount = frameCount +1
	if(frameCount>3):
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
