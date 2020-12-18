extends State

class_name FallingState
var min_move_speed = 20

func _ready():
	animationPlayer.play("falling")

func _physics_process(_delta):
# warning-ignore:unsafe_property_access

	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 0.01)
	if persistent_state.is_on_floor():
		if abs(persistent_state._velocity.x) < min_move_speed:
				change_state.call_func("idle")
		else:
			change_state.call_func("run")
	else: 
		persistent_state._velocity.y = min(persistent_state._velocity.y +persistent_state.gravity, persistent_state.maxFallSpeed)
		change_state.call_func("falling")
		if persistent_state._velocity.x < 0:
			sprite.flip_h = true
		elif persistent_state._velocity.x > 0:
			sprite.flip_h = false
		
		

func move_left():
	if sprite.flip_h:
		persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration, -persistent_state.maxRunSpeed)



func move_right():
	if not sprite.flip_h:
		persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration, persistent_state.maxRunSpeed )
		
func jump():
	pass
