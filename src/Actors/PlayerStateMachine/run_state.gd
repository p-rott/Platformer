extends State

class_name RunState


var min_move_speed = 20
var friction = 0.9


func _ready():
	animationPlayer.play("run")
	if sprite.flip_h:
	   persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration, -persistent_state.maxRunSpeed )
	else:
		persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration, persistent_state.maxRunSpeed )

func _physics_process(_delta):
	if abs(persistent_state._velocity.x) < min_move_speed:
		 change_state.call_func("idle")
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, 0.2)
	if(not persistent_state.is_on_floor()):
		change_state.call_func("falling")

func move_left():
	if sprite.flip_h:
		persistent_state._velocity.x = max(persistent_state._velocity.x-persistent_state.acceleration, -persistent_state.maxRunSpeed)

func move_right():
	if not sprite.flip_h:
		persistent_state._velocity.x = min(persistent_state._velocity.x+persistent_state.acceleration, persistent_state.maxRunSpeed )
		
func jump():
	change_state.call_func("jump")


