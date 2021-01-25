extends Node2D
class_name State

var change_state
var animationPlayer
var sprite : Sprite
var persistent_state 
func _physics_process(_delta):#
	if(persistent_state.jump_buffer > 0 and is_on_floor()):
		persistent_state.change_state("jump")
		persistent_state.jump_buffer = 0
	elif persistent_state.jump_buffer > 0:
		persistent_state.jump_buffer -= _delta
	else:
		persistent_state.jump_buffer = 0
	
	persistent_state._velocity.y = min(persistent_state._velocity.y +persistent_state.gravity, persistent_state.maxRunSpeed)
	var collision = persistent_state.move_and_collide(persistent_state._velocity * _delta)
	if collision:
		persistent_state._velocity = persistent_state._velocity.slide(collision.normal)
		if collision.collider is PlayerGoal and persistent_state.alive:
			persistent_state.goalReached()
		elif collision.collider is FallingPlatform:
			collision.collider.touched()
	persistent_state.move_and_slide(persistent_state._velocity, Vector2.UP, true)
	pass

func setup(change_state_p, animationPlayer_p, sprite_p, persistent_state_p):
	self.change_state = change_state_p
	self.animationPlayer = animationPlayer_p
	self.sprite = sprite_p
	self.persistent_state = persistent_state_p

func move_left():
	pass
func move_left_released():
	pass

func move_right():
	pass
	
func move_right_released():
	pass
	
func horizontal_stop():
	pass

func jump():
	pass

func jump_released():
	pass

func sprint_pressed():
	pass

func sprint_released():
	pass

func die():
	change_state.call_func("die") 

func is_on_floor():
	return persistent_state.platform_detector.is_colliding()
