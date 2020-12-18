extends State

class_name RunState


var min_move_speed = 20
var friction = 0.2
var acceleration
var maxRunSpeed

func _ready():
	acceleration = persistent_state.acceleration
	maxRunSpeed = persistent_state.maxRunSpeed
	animationPlayer.play("run")
	if sprite.flip_h:
	   persistent_state._velocity.x = max(persistent_state._velocity.x-acceleration, -maxRunSpeed )
	else:
		persistent_state._velocity.x = min(persistent_state._velocity.x+acceleration, maxRunSpeed )

func _physics_process(_delta):
	if abs(persistent_state._velocity.x) < min_move_speed:
		 change_state.call_func("idle")
	persistent_state._velocity.x = lerp(persistent_state._velocity.x, 0, friction)
	if(not is_on_floor()):
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
		persistent_state._velocity.x = min(persistent_state._velocity.x+acceleration, maxRunSpeed )
	else:
		sprite.flip_h = false
		persistent_state._velocity.x *=-persistent_state.changeMoveDirectionTempo
		
func jump():
	change_state.call_func("jump")
	
func sprint_pressed():
	change_state.call_func("sprint")
	pass


