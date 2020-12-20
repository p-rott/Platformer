extends State

class_name SlideState


var min_move_speed = 0.005
var friction = 0.32

func _ready():
	animationPlayer.play("run")
	

func _physics_process(_delta):
	if abs(persistent_state._velocity.x) < min_move_speed:
		 change_state.call_func("idle")
	#persistent_state._velocity.x *= friction

func move_left():
	persistent_state._velocity.x -= persistent_state.acceleration

func move_right():
	persistent_state._velocity.x += persistent_state.acceleration
