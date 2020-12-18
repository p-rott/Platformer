extends State

class_name JumpState
var min_move_speed = 20

func _ready():
	animationPlayer.play("jumping")
	persistent_state._velocity.y = -300

func _physics_process(_delta):
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 0.01)
	persistent_state._velocity.y = min(persistent_state._velocity.y +persistent_state.gravity, persistent_state.maxRunSpeed)
	if(persistent_state._velocity.y > 0 or persistent_state.is_on_ceiling()):
		persistent_state._velocity.y = 0
		change_state.call_func("falling")
	if persistent_state._velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		

func move_left():
	if sprite.flip_h:
		persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration, -persistent_state.maxRunSpeed)



func move_right():
	if not sprite.flip_h:
		persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration, persistent_state.maxRunSpeed )
		
func jump():
	pass
