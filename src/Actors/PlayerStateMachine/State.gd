extends Node2D

class_name State

var change_state
var animationPlayer
var sprite
var persistent_state 

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	persistent_state.move_and_slide(persistent_state._velocity, persistent_state.FLOOR_NORMAL)
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

