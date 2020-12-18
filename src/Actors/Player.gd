class_name Player
extends Actor

const FLOOR_DETECT_DISTANCE = 20.0
export var maxRunSpeed = 300
export var maxFallSpeed = 500
export var sprintIncrease = 1.1
export var acceleration = 75

var state
var state_factory


onready var platform_detector = $PlatformDetector
onready var wall_detector_left = $WallDetectorLeft
onready var wall_detector_right = $WallDetectorRight
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	# Static types are necessary here to avoid warnings.
	var camera: Camera2D = $Camera
	camera.custom_viewport = $"../.."
	state_factory = StateFactory.new()
	change_state("idle")


func move_left():
	state.move_left()


func move_right():
	state.move_right()
	
func jump():
	state.jump()

func change_state(new_state_name):
	if is_instance_valid(state):
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), animation_player, sprite, self)
	state.name = "current_state"
	add_child(state)

func _physics_process(_delta):
	if Input.is_action_pressed("move_left"):
		move_left()
	elif Input.is_action_pressed("move_right"):
		move_right()
	if Input.is_action_pressed("jump"):
		jump()


	#var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0 Pail meinte ich soll mir das anschauen

	pass


# This function calculates a new velocity whenever you need it.



