extends RunState
class_name SprintRunState

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	acceleration = persistent_state.acceleration * persistent_state.sprintIncrease
	maxRunSpeed = persistent_state.maxRunSpeed  * persistent_state.sprintIncrease
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func sprint_pressed():

	pass
