extends Node2D

class_name State

var change_state
var animationPlayer
var sprite : Sprite
var persistent_state 
# Writing _delta instead of delta here prevents the unused variable warning.


func _physics_process(_delta):
	persistent_state._velocity.y = min(persistent_state._velocity.y +persistent_state.gravity, persistent_state.maxRunSpeed)
	var collision = persistent_state.move_and_collide(persistent_state._velocity * _delta)
	if collision:
		persistent_state._velocity = persistent_state._velocity.slide(collision.normal)
		if collision.collider is Trap:
			persistent_state.change_state("die")
		elif collision.collider is PlayerGoal:
			persistent_state.goalReached()
	persistent_state.move_and_slide(persistent_state._velocity, Vector2.UP, true)
	pass

func setup(change_state, animationPlayer, sprite, persistent_state):
	self.change_state = change_state
	self.animationPlayer = animationPlayer
	self.sprite = sprite
	self.persistent_state = persistent_state

func move_left():
	pass


func move_right():
	pass
	
func jump():
	pass

func jump_released():
	pass

func sprint_pressed():
	pass
func sprint_released():
	pass
func is_on_floor():
	return persistent_state.platform_detector.is_colliding()

