extends State

class_name RunState


var min_move_speed = 20
var friction = 0.2
var acceleration
var maxRunSpeed
var coyote_buffer 
func _ready():
	acceleration = persistent_state.acceleration
	maxRunSpeed = persistent_state.maxRunSpeed
	coyote_buffer = persistent_state.coyote_time_s
	animationPlayer.play("run")
	if sprite.flip_h:
	   persistent_state._velocity.x = max(persistent_state._velocity.x-acceleration, -maxRunSpeed )
	else:
		persistent_state._velocity.x = min(persistent_state._velocity.x+acceleration, maxRunSpeed )

func _physics_process(_delta):
	if abs(persistent_state._velocity.x) < min_move_speed:
		 change_state.call_func("idle")
	if(not is_on_floor() && coyote_buffer > 0):
		coyote_buffer -=_delta
	elif(not is_on_floor()):
		persistent_state._velocity.y = 0
		change_state.call_func("falling")


func move_left():
	if sprite.flip_h:
		persistent_state._velocity.x = max(persistent_state._velocity.x-acceleration, -maxRunSpeed)
	else:
		sprite.flip_h = true
		persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo

func move_right():
	if not sprite.flip_h:
		var horizontalVelocity: float = persistent_state._velocity.x
		horizontalVelocity += persistent_state.acceleration
		
		persistent_state._velocity.x = min(horizontalVelocity, maxRunSpeed )
	else:
		sprite.flip_h = false
		persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo

func horizontal_stop():
	persistent_state._velocity.x *= 1 - persistent_state.grounded_hDamping

func jump():
	change_state.call_func("jump")
	
func sprint_pressed():
	change_state.call_func("sprint")
	pass

